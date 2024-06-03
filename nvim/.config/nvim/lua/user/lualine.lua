local M = {
	"nvim-lualine/lualine.nvim",
	event = "BufWinEnter",
	dependencies = {
		"AndreM222/copilot-lualine",
	},
}

function M.config()
	require("lualine").setup({
		options = {
			-- theme = "catppuccin",
			-- component_separators = { left = "", right = "" },
			-- section_separators = { left = "", right = "" },
			icons_enabled = true,
			component_separators = "|",
			section_separators = "",
			ignore_focus = { "NvimTree" },
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = { "branch", "diff", "diagnostics" },
			lualine_c = { "filename" },
			lualine_x = {
				{ "copilot", show_colors = true },
				{ "filetype" },
			},
			lualine_y = { "progress" },
			lualine_z = { "location" },
		},
		extensions = { "quickfix", "man", "fugitive" },
	})
end

return M
