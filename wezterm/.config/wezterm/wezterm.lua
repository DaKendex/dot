-- Pull in the wezterm API
local wezterm = require("wezterm")

local act = wezterm.action
local k = require("utils/keys")

-- This will hold the configuration.
local config = {

	-- This is where you actually apply your config choices
	-- color_scheme = "Tokyo Night",
	-- color_scheme = "Catppuccin Macchiato",
	-- For example, changing the color scheme:
	-- colors = {
	-- 	foreground = "#CBE0F0",
	-- 	background = "#011423",
	-- 	cursor_bg = "#47FF9C",
	-- 	cursor_border = "#47FF9C",
	-- 	cursor_fg = "#011423",
	-- 	selection_bg = "#706b4e",
	-- 	selection_fg = "#f3d9c4",
	-- 	ansi = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#0FC5ED", "#a277ff", "#24EAF7", "#24EAF7" },
	-- 	brights = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#A277FF", "#a277ff", "#24EAF7", "#24EAF7" },
	-- },

	font = wezterm.font("JetBrainsMono Nerd Font"),
	font_size = 18,

	enable_tab_bar = false,

	-- background = {
	-- 	{
	-- 		source = { File = { path = os.getenv("HOME") .. "/.config/wezterm/blob_blue.gif" } },
	-- 		height = "Cover",
	-- 		width = "Cover",
	-- 		horizontal_align = "Center",
	-- 		repeat_x = "Repeat",
	-- 		repeat_y = "Repeat",
	-- 		opacity = 1,
	-- 	},
	-- },
	window_decorations = "RESIZE",
	window_background_opacity = 0.8,
	macos_window_background_blur = 8,
	window_close_confirmation = "NeverPrompt",
	keys = {
		-- Make Option-Left equivalent to Alt-b which many line editors interpret as backward-word
		{
			key = "LeftArrow",
			mods = "OPT",
			action = wezterm.action({ SendString = "\x1bb" }),
		},
		-- Make Option-Right equivalent to Alt-f; forward-word
		{
			key = "RightArrow",
			mods = "OPT",
			action = wezterm.action({ SendString = "\x1bf" }),
		},
		{
			key = "LeftArrow",
			mods = "CMD",
			action = wezterm.action({ SendString = "\x1bOH" }),
		},
		{
			key = "RightArrow",
			mods = "CMD",
			action = wezterm.action({ SendString = "\x1bOF" }),
		},
		k.cmd_key("o", k.multiple_actions(":Octo")),
		k.cmd_key("i", k.multiple_actions(":SmartGoTo")),
		k.cmd_key("O", k.multiple_actions(":GoToSymbol")),
		k.cmd_key("P", k.multiple_actions(":GoToCommand")),
		k.cmd_key("p", k.multiple_actions(":GoToFile")),
		k.cmd_key("q", k.multiple_actions(":qa!")),
		k.cmd_to_tmux_prefix("1", "1"),
		k.cmd_to_tmux_prefix("2", "2"),
		k.cmd_to_tmux_prefix("3", "3"),
		k.cmd_to_tmux_prefix("4", "4"),
		k.cmd_to_tmux_prefix("k", "T"),
		k.cmd_to_tmux_prefix("j", "J"),
		k.cmd_to_tmux_prefix("g", "g"),
		k.cmd_to_tmux_prefix("G", "G"),
		k.cmd_to_tmux_prefix("e", "%"),
		k.cmd_to_tmux_prefix("E", '"'),
		k.cmd_to_tmux_prefix("c", "c"),
		k.cmd_to_tmux_prefix("x", "x"),
		k.cmd_key(
			"s",
			act.Multiple({
				act.SendKey({ key = "\x1b" }), -- escape
				k.multiple_actions(":w"),
			})
		),
	},
}
-- and finally, return the configuration to wezterm
return config
