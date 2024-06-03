local M = {
	"stevearc/oil.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
}

function M.config()
	require("oil").setup({
		columns = { "icon" },
		float = {
			enable = true,
			max_height = 40,
			max_width = 120,
		},
		keymaps = {
			["<S-h>"] = "actions.select_split",
		},
		view_options = {
			show_hidden = true,
		},
	})
	-- vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
	vim.keymap.set("n", "-", "<CMD>Oil --float<CR>", { desc = "Open parent directory" })
end

return M
