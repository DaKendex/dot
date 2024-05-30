local M = {
	"ThePrimeagen/git-worktree.nvim",
	event = "BufReadPre",
}

function M.config()
	require("git-worktree").setup({})
	local keymap = vim.keymap.set

	keymap(
		"n",
		"<leader>wt",
		"<cmd>lua require('telescope').extensions.git_worktree.git_worktrees()<CR>",
		{ noremap = true, silent = true, desc = "Git worktrees" }
	)
	keymap(
		"n",
		"<leader>wc",
		"<cmd>lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>",
		{ noremap = true, silent = true, desc = "Create Git worktree" }
	)
end

return M
