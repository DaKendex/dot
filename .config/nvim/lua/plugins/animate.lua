local M = {
	"echasnovski/mini.nvim",
	event = "VeryLazy",
	version = false,
}

function M.config()
	require("mini.animate").setup({
		scroll = {
			enable = false,
		},
	})
end

return M
