"""Tests for obsidian-moc-sync. Run: python3 -m unittest discover -s ~/.config/bin/tests"""

import importlib.machinery
import importlib.util
import tempfile
import textwrap
import unittest
from pathlib import Path

SCRIPT = Path(__file__).resolve().parent.parent / "obsidian-moc-sync"
_loader = importlib.machinery.SourceFileLoader("obsidian_moc_sync", str(SCRIPT))
_spec = importlib.util.spec_from_loader(_loader.name, _loader)
sync = importlib.util.module_from_spec(_spec)
_loader.exec_module(sync)


def note(tags, body="", extra=""):
    return f"---\nid: x\ntags: [{', '.join(tags)}]\n{extra}---\n{body}"


MOC = textwrap.dedent(
    """\
    ---
    id: moc-infra
    tags: [moc, infra]
    ---

    # Infrastructure

    `1` notes tagged `#infra`. Regenerate this list when it drifts.

    - [[stale]] - gone now
    - [[keep]] - hand-written description

    ## Related

    - [[index]]
    """
)


class VaultCase(unittest.TestCase):
    def setUp(self):
        self._tmp = tempfile.TemporaryDirectory()
        self.root = Path(self._tmp.name)

    def tearDown(self):
        self._tmp.cleanup()

    def put(self, rel, text):
        path = self.root / rel
        path.parent.mkdir(parents=True, exist_ok=True)
        path.write_text(text, encoding="utf-8")

    def read(self, rel):
        return (self.root / rel).read_text(encoding="utf-8")

    def run_sync(self, *args):
        return sync.main(["--vault", str(self.root), *args])


class FrontmatterTest(unittest.TestCase):
    def test_inline_list(self):
        meta, body = sync.parse_frontmatter("---\ntags: [a, b]\n---\nbody")
        self.assertEqual(meta["tags"], ["a", "b"])
        self.assertEqual(body, "body")

    def test_block_list_and_quoted_scalar(self):
        meta, _ = sync.parse_frontmatter('---\ntags:\n  - a\n  - "b"\nsummary: "hi"\n---\n')
        self.assertEqual(meta["tags"], ["a", "b"])
        self.assertEqual(meta["summary"], "hi")

    def test_no_frontmatter(self):
        meta, body = sync.parse_frontmatter("# just text")
        self.assertEqual(meta, {})
        self.assertEqual(body, "# just text")


class MocTest(VaultCase):
    def setUp(self):
        super().setUp()
        self.put("moc-infra.md", MOC)
        self.put("keep.md", note(["infra"], "# Keep heading\n"))
        self.put("new-note.md", note(["infra"], "# New note heading\n"))
        self.put("summarized.md", note(["infra"], "# Ignored\n", 'summary: "From summary"\n'))
        self.put("other.md", note(["vuln"], "# Other\n"))
        self.put("sub/nested.md", note(["infra"], "# Nested\n"))

    def test_dry_run_reports_drift_without_writing(self):
        self.assertEqual(self.run_sync(), 1)
        self.assertEqual(self.read("moc-infra.md"), MOC)

    def test_write_regenerates_list_and_count(self):
        self.assertEqual(self.run_sync("--write"), 0)
        text = self.read("moc-infra.md")
        self.assertIn("`3` notes tagged `#infra`. Regenerate this list when it drifts.", text)
        self.assertIn("- [[keep]] - hand-written description", text)
        self.assertIn("- [[new-note]] - New note heading", text)
        self.assertIn("- [[summarized]] - From summary", text)
        self.assertNotIn("stale", text)
        self.assertNotIn("other", text)
        self.assertNotIn("nested", text)  # root-level notes only
        self.assertIn("## Related\n\n- [[index]]", text)  # untouched section
        self.assertEqual(self.run_sync(), 0)  # idempotent

    def test_symlinked_note_not_double_counted(self):
        (self.root / "alias.md").symlink_to(self.root / "keep.md")
        self.run_sync("--write")
        text = self.read("moc-infra.md")
        self.assertIn("`3` notes tagged `#infra`", text)
        self.assertNotIn("[[alias]]", text)

    def test_members_sorted_case_insensitively(self):
        self.put("Zeta.md", note(["infra"]))
        self.put("Alpha.md", note(["infra"]))
        self.run_sync("--write")
        text = self.read("moc-infra.md")
        order = [l.split("]]")[0][4:] for l in text.split("\n") if l.startswith("- [[") and "index" not in l]
        self.assertEqual(order, ["Alpha", "keep", "new-note", "summarized", "Zeta"])

    def test_summary_beats_existing_description(self):
        self.put("keep.md", note(["infra"], "", 'summary: "New summary"\n'))
        self.run_sync("--write")
        self.assertIn("- [[keep]] - New summary", self.read("moc-infra.md"))

    def test_moc_without_single_tag_is_skipped(self):
        self.put("moc-multi.md", MOC.replace("[moc, infra]", "[moc, infra, vuln]"))
        before = self.read("moc-multi.md")
        self.run_sync("--write")
        self.assertEqual(self.read("moc-multi.md"), before)

    def test_moc_tag_key_disambiguates(self):
        self.put("moc-multi.md", MOC.replace("[moc, infra]", "[moc, infra, vuln]\nmoc_tag: vuln"))
        self.run_sync("--write")
        text = self.read("moc-multi.md")
        self.assertIn("`1` notes tagged `#vuln`", text)
        self.assertIn("- [[other]] - Other", text)


class IndexTest(VaultCase):
    def setUp(self):
        super().setUp()
        self.put("a.md", note(["infra"]))
        self.put("b.md", note(["infra"]))
        self.put("c.md", note(["ops"]))
        self.put("daily/2026-01-01.md", "")
        self.put("daily/2026-01-03.md", "")
        self.put(
            "index.md",
            textwrap.dedent(
                """\
                ---
                tags: [moc]
                ---
                - [[moc-infra|Infra]] - `9` notes `#infra`
                - `daily/` - 1 notes, latest [[daily/2025-12-31]]
                - `missing/` - 4 notes, latest [[missing/x]]
                - `#ops` - [[old]]
                - hand-written line stays
                """
            ),
        )

    def test_index_lines_updated(self):
        self.run_sync("--write")
        text = self.read("index.md")
        self.assertIn("- [[moc-infra|Infra]] - `2` notes `#infra`", text)
        self.assertIn("- `daily/` - 2 notes, latest [[daily/2026-01-03]]", text)
        self.assertIn("- `missing/` - 4 notes, latest [[missing/x]]", text)  # no dir: untouched
        self.assertIn("- `#ops` - [[c]]", text)
        self.assertIn("- hand-written line stays", text)


class GuardTest(VaultCase):
    def test_refuses_non_vault(self):
        self.assertEqual(self.run_sync(), 2)


if __name__ == "__main__":
    unittest.main()
