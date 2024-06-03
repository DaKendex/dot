local M = {
	"folke/todo-comments.nvim",
	event = "BufReadPre",
	dependencies = {
		"nvim-lua/plenary.nvim",
		--TODO: Add dependency
	},
}

function M.config()
	require("todo-comments").setup()
end

return M
