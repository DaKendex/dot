local M = {
	"stevearc/oil.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
}

function M.config()
	require("oil").setup({
		float = {
			enable = true,
			-- max_height = 20,
			-- max_width = 60,
		},
		view_options = {
			show_hidden = true,
		},
	})
	-- vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
	vim.keymap.set("n", "-", "<CMD>Oil --float<CR>", { desc = "Open parent directory" })
end

return M
