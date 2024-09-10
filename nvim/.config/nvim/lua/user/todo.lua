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
	vim.keymap.set("n", "<leader>td", "<cmd>TodoTelescope<CR>", { silent = true, noremap = true })
end

return M
