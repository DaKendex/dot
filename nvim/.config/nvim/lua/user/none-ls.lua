local M = {
	"nvimtools/none-ls.nvim",
	event = "BufReadPre",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
}

function M.config()
	local null_ls = require("null-ls")

	local formatting = null_ls.builtins.formatting
	local diagnostics = null_ls.builtins.diagnostics

	null_ls.setup({
		debug = false,
		sources = {
			formatting.stylua,
			formatting.prettier,
			formatting.black,
			formatting.goimports_reviser,
			formatting.golines,
			formatting.gofumpt,
			-- formatting.prettier.with {
			--   extra_filetypes = { "toml" },
			--   -- extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
			-- },
			diagnostics.actionlint,
			null_ls.builtins.completion.spell,
		},
	})
end

return M
