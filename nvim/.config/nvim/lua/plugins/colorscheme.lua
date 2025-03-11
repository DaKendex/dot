local M = {
	-- "folke/tokyonight.nvim",
	"catppuccin/nvim",
	-- "Mofiqul/vscode.nvim",
	as = "catppuccin",
	lazy = false,
	priority = 1000,
}

function M.config()
	-- require("tokyonight").setup({
	-- 	style = "storm",
	-- 	transparent = true,
	-- 	styles = {
	-- 		comments = "italic",
	-- 		-- functions = "italic",
	-- 		-- keywords = "italic",
	-- 		-- strings = "italic",
	-- 		-- variables = "italic",
	-- 	},
	-- })
	-- vim.cmd.colorscheme("tokyonight")

	require("catppuccin").setup({
		flavour = "macchiato",
		transparent_background = true,
		styles = {
			-- comments = { "italic" },
			-- functions = { "italic" },
			-- keywords = { "italic" },
			-- strings = { "italic" },
			-- variables = { "italic" },
		},
		no_underline = true,
		integrations = {
			harpoon = true,
			cmp = true,
			gitsigns = true,
			telescope = true,
			which_key = true,
			neogit = true,
			mason = true,
			native_lsp = {
				enabled = true,
				virtual_text = {
					errors = { "italic" },
					hints = { "italic" },
					warnings = { "italic" },
					information = { "italic" },
				},
			},
		},
	})
	vim.cmd.colorscheme("catppuccin")

	-- require("vscode").setup()
	-- vim.cmd.colorscheme("vscode")
end

return M
