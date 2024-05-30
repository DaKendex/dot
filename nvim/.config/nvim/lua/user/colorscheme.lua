local M = {
	-- "folke/tokyonight.nvim",
	"catppuccin/nvim",
	as = "catppuccin",
	lazy = false,
	priority = 1000,
}

function M.config()
	-- require("tokyonight").setup({
	--   style = "storm",
	--   transparent = true,
	--   styles = {
	--     comments = "italic",
	--     -- functions = "italic",
	--     -- keywords = "italic",
	--     -- strings = "italic",
	--     -- variables = "italic",
	--   }
	-- })
	-- vim.cmd.colorscheme("tokyonight")
	require("catppuccin").setup({
		flavour = "macchiato",
		styles = {
			comments = { "italic" },
			functions = { "italic" },
			keywords = { "italic" },
			strings = { "italic" },
			variables = { "italic" },
		},
	})
	vim.cmd.colorscheme("catppuccin")
end

return M
