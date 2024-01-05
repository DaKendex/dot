-- local mark = require("harpoon.mark")
-- local ui = require("harpoon.ui")

-- lvim.keys.normal_mode["<leader>hm"] = mark.add_file
-- lvim.keys.normal_mode["<leader>hh"] = ui.toggle_quick_menu
-- lvim.keys.normal_mode["<leader>hn"] = function()
-- 	ui.nav_next()
-- end
-- lvim.keys.normal_mode["<leader>hp"] = function()
-- 	ui.nav_prev()
-- end
local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local h_status_ok, harpoon = pcall(require, "harpoon")
if not h_status_ok then
  return
end
telescope.load_extension "harpoon"
