const enabledInput = document.getElementById("enabled");
const hoursInput = document.getElementById("hours");

chrome.storage.local.get(AUTO_CLOSE_DEFAULTS).then((settings) => {
  enabledInput.checked = settings.autoCloseEnabled;
  hoursInput.value = settings.autoCloseHours;
});

enabledInput.addEventListener("change", () => {
  chrome.storage.local.set({ autoCloseEnabled: enabledInput.checked });
});

hoursInput.addEventListener("change", () => {
  const hours = Math.max(1, Math.round(Number(hoursInput.value)) || AUTO_CLOSE_DEFAULTS.autoCloseHours);
  hoursInput.value = hours;
  chrome.storage.local.set({ autoCloseHours: hours });
});
