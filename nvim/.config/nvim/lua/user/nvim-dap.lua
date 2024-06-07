local M = {
	"mfussenegger/nvim-dap",
	event = "BufReadPre",
}
function M.config()
	-- local opts = { noremap = false, silent = true }
	local keymap = vim.keymap.set
	keymap("n", "<leader>db", "<cmd> DapToggleBreakpoint <CR>", { desc = "Add breakpoint at line" })
	keymap("n", "<leader>dus", function()
		local widgets = require("dap.ui.widgets")
		local sidebar = widgets.sidebar(widgets.scopes)
		sidebar.open()
	end, { desc = "Open debugging sidebar" })
end
return M
