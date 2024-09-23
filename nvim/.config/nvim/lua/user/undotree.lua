local M = {
	"mbbill/undotree",
}

function M.config()
	-- require("undotree").setup({})
end

vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { noremap = true, silent = true })


return M
