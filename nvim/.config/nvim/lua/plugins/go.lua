local M = {
	"ray-x/go.nvim",
	dependencies = {
		"ray-x/guihua.lua",
		"neavim/nvim-lspconfig",
		"nvim-treesitter/nvim-treesitter",
	},
	event = { "CmdlineEnter" },
	ft = { "go", "gomod" },
}

-- Run gofmt + goimports on save

-- local format_sync_grp = vim.api.nvim_create_augroup("goimports", {})
-- vim.api.nvim_create_autocmd("BufWritePre", {
-- 	pattern = "*.go",
-- 	callback = function()
-- 		require("go.format").goimports()
-- 	end,
-- 	group = format_sync_grp,
-- })

function M.config()
	require("go").setup({
		diagnostic = {
			hdlr = false,
			underline = true,
			virtual_text = { spacing = 0, prefix = "■" },
			update_in_insert = false,
			signs = true, -- use a table to configure the signs texts
		},
	})
end

return M
