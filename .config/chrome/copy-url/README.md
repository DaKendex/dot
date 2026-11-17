# Copy URL

Chrome extension that copies the current tab URL with `Cmd+Shift+C` (Arc's shortcut). Clicking the toolbar icon does the same. The icon badge flashes `✓` on success, `!` on failure.

Permissions: `activeTab`, `offscreen`, `clipboardWrite`. No host permissions, no network access.

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

- Does not work on `chrome://` pages or the Web Store.
- With DevTools focused, `⌘⇧C` may still trigger inspect-element.
- Managed Chrome may block unpacked extensions (check `chrome://policy`).
- After editing files, click the reload icon on the extension card in `chrome://extensions`.

## Files

- `manifest.json` - MV3 manifest and command binding.
- `background.js` - handles the command and toolbar click, gets the tab URL.
- `offscreen.html` / `offscreen.js` - writes to the clipboard (`navigator.clipboard` needs focus, which offscreen documents never have).
