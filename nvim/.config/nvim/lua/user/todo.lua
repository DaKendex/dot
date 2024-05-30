local M = {
	"folke/todo-comments.nvim",
	event = "BufReadPre",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	events = "BufReadPre",
}

function M.config() end

return M
