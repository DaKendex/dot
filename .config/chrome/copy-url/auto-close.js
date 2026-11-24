const AUTO_CLOSE_ALARM = "auto-close";
// Equals chrome.tabGroups.TAB_GROUP_ID_NONE; the literal avoids needing the tabGroups permission.
const NO_GROUP = -1;

// Alarms are not guaranteed to survive a browser restart, so recreate on every worker start.
async function ensureAutoCloseAlarm() {
  if (!(await chrome.alarms.get(AUTO_CLOSE_ALARM))) {
    await chrome.alarms.create(AUTO_CLOSE_ALARM, { periodInMinutes: 30 });
  }
}

function isStale(tab, cutoff) {
  return (
    !tab.active &&
    !tab.pinned &&
    !tab.audible &&
    tab.groupId === NO_GROUP &&
    typeof tab.lastAccessed === "number" &&
    tab.lastAccessed < cutoff
  );
}

async function closeStaleTabs() {
  const { autoCloseEnabled, autoCloseHours } = await chrome.storage.local.get(AUTO_CLOSE_DEFAULTS);
  if (!autoCloseEnabled || !(autoCloseHours >= 1)) return;

  const cutoff = Date.now() - autoCloseHours * 60 * 60 * 1000;
  const stale = (await chrome.tabs.query({})).filter((tab) => isStale(tab, cutoff));
  if (stale.length > 0) await chrome.tabs.remove(stale.map((tab) => tab.id));
}

chrome.alarms.onAlarm.addListener((alarm) => {
  if (alarm.name !== AUTO_CLOSE_ALARM) return;
  closeStaleTabs().catch((err) => console.error("auto-close:", err));
});

ensureAutoCloseAlarm();
