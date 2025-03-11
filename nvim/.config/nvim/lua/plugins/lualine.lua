local M = {
	"nvim-lualine/lualine.nvim",
	event = "BufWinEnter",
	dependencies = {
		"AndreM222/copilot-lualine",
	},
}

local colors = {
	blue = "#80a0ff",
	cyan = "#79dac8",
	black = "#080808",
	white = "#c6c6c6",
	red = "#ff5189",
	violet = "#d183e8",
	grey = "#303030",
}

local bubbles_theme = {
	normal = {
		a = { fg = colors.black, bg = colors.violet },
		b = { fg = colors.white, bg = colors.grey },
		c = { fg = colors.white },
	},

	insert = { a = { fg = colors.black, bg = colors.blue } },
	visual = { a = { fg = colors.black, bg = colors.cyan } },
	replace = { a = { fg = colors.black, bg = colors.red } },

	inactive = {
		a = { fg = colors.white, bg = colors.black },
		b = { fg = colors.white, bg = colors.black },
		c = { fg = colors.white },
	},
}

function M.config()
	require("lualine").setup({
		options = {
			theme = bubbles_theme,
			component_separators = "",
			section_separators = { left = "", right = "" },
			icons_enabled = true,
			ignore_focus = { "NvimTree" },
		},
		sections = {
			lualine_a = { { "mode", separator = { left = "" }, right_padding = 2 } },
			lualine_b = { "branch" },
			lualine_c = { "filename" },
			lualine_x = {
				{ "copilot", show_colors = true },
			},
			lualine_y = { "filetype", "progress" },
			lualine_z = {
				{ "location", separator = { right = "" }, left_padding = 2 },
			},
		},
		extensions = { "quickfix", "man", "fugitive" },
	})
end

return M
