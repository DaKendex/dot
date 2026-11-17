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

async function copyActiveTabUrl(tab) {
  try {
    if (!tab) {
      [tab] = await chrome.tabs.query({ active: true, lastFocusedWindow: true });
    }
    if (!tab?.url) throw new Error("no URL available for active tab");
    await ensureOffscreen();
    const ok = await chrome.runtime.sendMessage({ type: "copy", text: tab.url });
    if (!ok) throw new Error("clipboard write failed");
    await flashBadge("✓", "#1a7f37");
  } catch (err) {
    console.error("copy-url:", err);
    await flashBadge("!", "#cf222e");
  }
}

chrome.commands.onCommand.addListener((command, tab) => {
  if (command === "copy-url") copyActiveTabUrl(tab);
});

chrome.action.onClicked.addListener((tab) => copyActiveTabUrl(tab));
