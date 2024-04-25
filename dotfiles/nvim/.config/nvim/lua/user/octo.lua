local M = {
	"pwntester/octo.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
		"nvim-tree/nvim-web-devicons",
	},
}

function M.config()
	local keymap = vim.keymap.set
	local opts = { noremap = true, silent = true }

	keymap("n", "<leader>O", "<cmd>Octo<CR>", opts)
	require("octo").setup({
		enable_builtin = true,
    suppress_missing_scope = {
      projects_v2 = true,
    }
	})
end

return M
