# Copy URL

Chrome extension that copies the current tab URL with `Cmd+Shift+C` (Arc's shortcut). Clicking the toolbar icon does the same. A "Copied URL" toast shows at the bottom of the page, and the icon badge flashes `✓` on success, `!` on failure.

It also auto-closes tabs left unused for 48 hours (Arc-style auto-archive).

Permissions: `activeTab`, `offscreen`, `clipboardWrite`, `scripting`, `alarms`, `storage`. `scripting` only injects the toast, and only into the active tab at the moment you invoke the command (`activeTab`). Auto-close reads only tab state (`lastAccessed`, pinned, group, audible), never URLs or titles, so it does not need the `tabs` permission. No host permissions, no network access.

## Auto-close

Every 30 minutes, closes tabs not activated within the timeout (default 48 hours). Never closed: pinned tabs, tabs in a group, tabs playing audio, and the active tab in each window (so a window never closes on its own).

To keep a tab, pin it or put it in a group. To recover a closed tab, use `⌘⇧T` or History > Recently closed (Chrome keeps about 25).

Change the timeout or turn it off: `chrome://extensions` > **Copy URL** > **Details** > **Extension options**.

## Install

1. `chrome://extensions` - enable **Developer mode**.
2. **Load unpacked** - select this directory.
3. `chrome://extensions/shortcuts` - confirm **Copy current tab URL** is `⌘⇧C`.

## Set the shortcut manually

Chrome drops the suggested shortcut if it conflicts (`⌘⇧C` is DevTools inspect-element).

1. `chrome://extensions/shortcuts` - **Copy URL** card.
2. Click the pencil icon on **Copy current tab URL**, press `⌘⇧C`. It saves on keypress.
3. Leave scope on **In Chrome**.

If it shows "already in use", clear the shortcut on the other extension first. If it won't take the combo, use `⌥⇧C` or `⌘⇧Y`.

## Limitations

- Does not work on `chrome://` pages or the Web Store. Where Chrome blocks the toast but the copy succeeds, only the badge confirms.
- With DevTools focused, `⌘⇧C` may still trigger inspect-element.
- Managed Chrome may block unpacked extensions (check `chrome://policy`).
- After editing files, click the reload icon on the extension card in `chrome://extensions`.
- Auto-close uses `chrome.tabs.remove`, which skips "leave site?" prompts. An unsaved draft in a tab untouched for the full timeout is lost; pin or group tabs like that.

## Files

- `manifest.json` - MV3 manifest and command binding.
- `background.js` - handles the command and toolbar click, gets the tab URL, injects the toast.
- `offscreen.html` / `offscreen.js` - writes to the clipboard (`navigator.clipboard` needs focus, which offscreen documents never have).
- `auto-close.js` - alarm and stale-tab sweep, loaded by `background.js`.
- `settings.js` - auto-close defaults, shared by the service worker and the options page.
- `options.html` / `options.js` - auto-close timeout and on/off toggle.
