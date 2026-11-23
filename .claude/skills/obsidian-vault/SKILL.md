---
name: obsidian-vault
description: Use when reading, creating, editing, retagging, moving, or splitting notes in an Obsidian vault, when a note's frontmatter, wikilinks, tags, or MOC (map of content) lists need to change, or when setting up a new vault. Applies to any vault with an AGENTS.md, index.md, or moc-*.md notes.
---

# Obsidian vault conventions

Shared conventions for flat, tag-organized Obsidian vaults. The vault's own `AGENTS.md` adds what
is specific to it (extra folders, undeclared tags, skills). Where the two disagree, `AGENTS.md`
wins.

For Obsidian syntax (callouts, embeds, properties), use the `obsidian-markdown` skill.

## Setup runbook

[SETUP.md](SETUP.md) in this skill directory stands up a new vault of this kind from scratch. Follow
it when asked to set up a vault.

Keep it current: when you change these conventions, templates, `.obsidian` config, the skill set,
`obsidian-moc-sync`, or the global vault instructions, update SETUP.md in the same change. Its
"Maintaining this file" section has the full trigger list. SETUP.md is public: keep it generic, no
employer names, ticket keys, user IDs, or note content.

## Before any edit

Vaults are not under version control. There is no undo.

- Read a note before writing to it.
- Prefer an append or targeted edit over a rewrite.
- Never bulk-rewrite, rename, or move notes unless asked.
- Never write secrets, tokens, credentials, or raw sensitive data. Describe and link instead.

## Layout

Flat. Every topic note lives at the vault root. Folders are structural, never topical:

| Folder | Contents |
|---|---|
| `daily/` | `YYYY-MM-DD.md` |
| `standups/` | `standup-YYYY-MM-DD.md` - the prefix keeps basenames unique across `daily/` |
| `templates/` | Templater templates |

A new subject gets a tag, not a folder. A cluster that feels like it needs a folder needs a MOC.
Create a folder only when the user asks for one.

## Frontmatter

Every note starts with it, in inline-array style:

```yaml
---
id: kebab-case-slug
aliases: []
tags: [topic]
---
```

- `id` is the filename slug, lowercased (`ABC-123.md` has `id: abc-123`).
- `aliases` holds human-readable names (full names for person notes) so wikilinks resolve.
- Time-series notes add `date` or `week_of`, plus `sources: [...]` listing where content came from.
- Optional `summary:` becomes the note's MOC bullet description.
- Preserve existing keys and their order. Do not reformat keys you did not touch.

## Links

- `[[wikilinks]]` inside the vault, Markdown links for external URLs.
- Link the first mention per note, not every mention.
- Link time-series notes by path: `[[daily/2026-10-19]]`.
- If the target note does not exist, still write the link. An unresolved link marks a gap. Do not
  create stub notes.
- When several person notes share a first name, link the full name or alias, never the bare first
  name.

## Tags

The tag vocabulary lives in `index.md`. Pick an existing tag. Add a new one only when a cluster
outgrows `#scratch`. Match neighbouring notes on undeclared tags rather than normalizing them,
unless asked to clean up.

## Maps of content

Each topic tag has a `moc-<tag>.md` listing its notes, and `index.md` links every MOC. MOC lists,
counts, and `index.md` count and "latest" lines are generated from tags by `obsidian-moc-sync`.
Never hand-edit them. Hand-written MOC text outside the generated list (intro, `## Related`) is
safe to edit.

After creating, retagging, deleting, or splitting a root note, run from the vault root:

```sh
obsidian-moc-sync          # dry run: prints a diff, exits 1 on drift
obsidian-moc-sync --write  # apply
```

Exit 2 or command not found: say so and skip. Do not hand-edit MOCs as a fallback.

## Templates

In `templates/`, leave Templater placeholders (`{{date:YYYY-MM-DD}}`, `{{yesterday}}`) literal.
In real notes, resolve them to actual dates.

## Writing style

- Plain dash (`-`), never an em dash.
- Concise and factual. No marketing voice, no filler preamble.
- Absolute dates (`2026-09-21`), never "last week".
- Record the source (Slack, Jira, GitHub, meeting notes) so a note can be re-derived.

## Note size and splitting

Soft limit: ~400 lines or ~25 KB per topic note. Daily, standup, and generated MOC notes are exempt.

- Before adding to an oversized note, propose a split. Never split unprompted.
- Split by facet (`-decisions`, `-log`, `-tickets`, `-2026-q3`), not by line count.
- The original stays as the hub: same filename and `id`, so inbound links resolve. It keeps the
  summary, current status, and links to each child.
- Children are root-level `<parent>-<facet>.md` notes with their own frontmatter, the parent's
  tags, and a link back to the hub.
- Move content verbatim. Do not summarize or drop detail.
- Raw dumps (scan output, transcripts, query results) go in a `-raw` child from the start.
- Run `obsidian-moc-sync --write` after a split.

## Common mistakes

| Mistake | Fix |
|---|---|
| Creating a topic folder | Tag the note at the root; the MOC indexes it |
| Editing a MOC list or count by hand | Run `obsidian-moc-sync --write` |
| Overwriting a note without reading it | Read first, then targeted edit |
| Linking a bare shared first name | Link the full name or alias |
| Splitting an oversized note unprompted | Propose the split, wait for a yes |
