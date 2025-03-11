local M = {
	"NeogitOrg/neogit",
	dependencies = {
		"nvim-lua/plenary.nvim", -- required
		"sindrets/diffview.nvim", -- optional - Diff integration
		"nvim-telescope/telescope.nvim", -- optional
		event = "VeryLazy",
		branch = "nightly",
	},
	config = true,
}

function M.config()
	-- This contains mainly Neogit but also a bunch of Git settings
	-- like fetching branches with telescope or blaming with fugitive
	local neogit = require("neogit")
	local set = vim.keymap.set

	set("n", "<leader>gs", neogit.open, { silent = true, noremap = true })

	set("n", "<leader>gc", ":Neogit commit<CR>", { silent = true, noremap = true })

	set("n", "<leader>gp", ":Neogit pull<CR>", { silent = true, noremap = true })

	set("n", "<leader>gP", ":Neogit push<CR>", { silent = true, noremap = true })

	set("n", "<leader>gb", ":Telescope git_branches<CR>", { silent = true, noremap = true })

	set("n", "<leader>gB", ":G blame<CR>", { silent = true, noremap = true })
	neogit.setup({
		kind = "split",
	})
end

return M
