local M = {
	"lewis6991/gitsigns.nvim",
	event = "BufEnter",
	cmd = "Gitsigns",
}
M.config = function()
	-- local icons = require "user.icons"

	vim.keymap.set(
		{ "n", "v" },
		"gj",
		"<cmd>lua require 'gitsigns'.next_hunk({navigation_message = false})<cr>zz",
		{ desc = "Next Hunk" }
	)
	vim.keymap.set(
		{ "n", "v" },
		"gk",
		"<cmd>lua require 'gitsigns'.prev_hunk({navigation_message = false})<cr>zz",
		{ desc = "Prev Hunk" }
	)
	vim.keymap.set({ "n", "v" }, "hp", "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", { desc = "Preview Hunk" })
	vim.keymap.set({ "n", "v" }, "hr", "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", { desc = "Reset Hunk" })
	vim.keymap.set({ "n", "v" }, "hs", ":Gitsigns stage_hunk<CR>", { desc = "Stage Hunk" })
	vim.keymap.set({ "n", "v" }, "<leader>gl", ":Gitsigns blame_line<CR>", { desc = "Blame" })
	vim.keymap.set(
		{ "n", "v" },
		"<leader>gR",
		"<cmd>lua require 'gitsigns'.reset_buffer()<cr>",
		{ desc = "Reset Buffer" }
	)
	vim.keymap.set(
		{ "n", "v" },
		"hu",
		"<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
		{ desc = "Undo Stage Hunk" }
	)
	vim.keymap.set({ "n", "v" }, "<leader>gd", "<cmd>Gitsigns diffthis HEAD<cr>", { desc = "Git Diff" })

	require("gitsigns").setup({
		signs = {
			add = { text = "+" },
			change = { text = "~" },
			delete = { text = "_" },
			topdelete = { text = "‾" },
			changedelete = { text = "~" },
		},
		watch_gitdir = {
			interval = 1000,
			follow_files = true,
		},
		attach_to_untracked = true,
		current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
		update_debounce = 200,
		max_file_length = 40000,
		preview_config = {
			border = "rounded",
			style = "minimal",
			relative = "cursor",
			row = 0,
			col = 1,
		},
	})
end

return M
