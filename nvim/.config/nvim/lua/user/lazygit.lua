local M = {
	"kdheepak/lazygit.nvim",
	event = "VeryLazy",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
}

vim.keymap.set({ "n", "v" }, "<leader>gg", "<cmd>LazyGit<CR>", { desc = "LazyGit" })
return M
