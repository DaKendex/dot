local M = {
	"linrongbin16/gitlinker.nvim",
	dependencies = { { "nvim-lua/plenary.nvim" } },
	event = "VeryLazy",
}
-- GitLink: generate git link and copy to clipboard.
-- GitLink!: generate git link and open in browser.
-- GitLink blame: generate the /blame url and copy to clipboard.
-- GitLink! blame: generate the /blame url and open in browser.

function M.config()
	vim.keymap.set({ "n", "v" }, "<leader>gy", "<cmd>GitLink<cr>", { desc = "Git link" })
	vim.keymap.set({ "n", "v" }, "<leader>gY", "<cmd>GitLink!<cr>", { desc = "Open link" })
	vim.keymap.set({ "n", "v" }, "<leader>gb", "<cmd>GitLink blame<cr>", { desc = "Git link blame" })
	vim.keymap.set({ "n", "v" }, "<leader>gL", "<cmd>GitLink! blame<cr>", { desc = "Open Git blame link" })

	require("gitlinker").setup({
		console_log = true,
	})
end

return M
