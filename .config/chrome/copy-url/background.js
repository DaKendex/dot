importScripts("settings.js", "auto-close.js");

const OFFSCREEN_URL = "offscreen.html";

// Offscreen documents never have focus, so navigator.clipboard is unavailable there;
// execCommand("copy") in an offscreen document is the documented MV3 clipboard path.
async function ensureOffscreen() {
  const existing = await chrome.runtime.getContexts({
    contextTypes: ["OFFSCREEN_DOCUMENT"],
    documentUrls: [chrome.runtime.getURL(OFFSCREEN_URL)],
  });
  if (existing.length > 0) return;
  await chrome.offscreen.createDocument({
    url: OFFSCREEN_URL,
    reasons: ["CLIPBOARD"],
    justification: "Write the current tab URL to the clipboard",
  });
}

async function flashBadge(text, color) {
  await chrome.action.setBadgeBackgroundColor({ color });
  await chrome.action.setBadgeText({ text });
  setTimeout(() => chrome.action.setBadgeText({ text: "" }), 1200);
}

// Runs in the page's isolated world. Shadow DOM keeps page CSS from restyling the toast,
// and CSSOM style assignments are not blocked by page CSP the way style attributes are.
function showToast(text) {
  const id = "__copy_url_toast__";
  document.getElementById(id)?.remove();

  const host = document.createElement("div");
  host.id = id;
  host.style.cssText =
    "all:initial;position:fixed;z-index:2147483647;left:50%;bottom:24px;" +
    "transform:translateX(-50%);pointer-events:none;";
  const pill = document.createElement("div");
  pill.textContent = text;
  pill.style.cssText =
    "font:500 13px -apple-system,BlinkMacSystemFont,system-ui,sans-serif;color:#fff;" +
    "background:rgba(28,28,30,.92);padding:8px 14px;border-radius:999px;" +
    "box-shadow:0 4px 16px rgba(0,0,0,.25);white-space:nowrap;" +
    "opacity:0;transition:opacity .15s ease;";
  host.attachShadow({ mode: "closed" }).append(pill);
  (document.body || document.documentElement).append(host);

  requestAnimationFrame(() => requestAnimationFrame(() => (pill.style.opacity = "1")));
  setTimeout(() => {
    pill.style.opacity = "0";
    setTimeout(() => host.remove(), 200);
  }, 1400);
}

async function toast(tabId, text) {
  try {
    await chrome.scripting.executeScript({ target: { tabId }, func: showToast, args: [text] });
  } catch {
    // Injection is refused on chrome://, the Web Store, and similar pages; the badge still confirms.
  }
}

async function copyActiveTabUrl(tab) {
  try {
    if (!tab) {
      [tab] = await chrome.tabs.query({ active: true, lastFocusedWindow: true });
    }
    if (!tab?.url) throw new Error("no URL available for active tab");
    await ensureOffscreen();
    const ok = await chrome.runtime.sendMessage({ type: "copy", text: tab.url });
    if (!ok) throw new Error("clipboard write failed");
    await Promise.all([flashBadge("✓", "#1a7f37"), toast(tab.id, "Copied URL")]);
  } catch (err) {
    console.error("copy-url:", err);
    await flashBadge("!", "#cf222e");
  }
}

chrome.commands.onCommand.addListener((command, tab) => {
  if (command === "copy-url") copyActiveTabUrl(tab);
});

chrome.action.onClicked.addListener((tab) => copyActiveTabUrl(tab));
