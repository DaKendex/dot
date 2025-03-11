local M = {
	"saghen/blink.cmp",
	dependencies = { "rafamadriz/friendly-snippets" },
  enabled = false,
	build = "cargo build --release",
	opts = {
		-- 'default' (recommended) for mappings similar to built-in completions (C-y to accept, C-n/C-p for up/down)
		-- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys for up/down)
		-- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
		--
		-- All presets have the following mappings:
		-- C-space: Open menu or open docs if already open
		-- C-e: Hide menu
		-- C-k: Toggle signature help
		--
		-- See the full "keymap" documentation for information on defining your own keymap.
		keymap = { preset = "default" },

		appearance = {
			-- Sets the fallback highlight groups to nvim-cmp's highlight groups
			-- Useful for when your theme doesn't support blink.cmp
			-- Will be removed in a future release
			use_nvim_cmp_as_default = true,
			-- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
			-- Adjusts spacing to ensure icons are aligned
			nerd_font_variant = "mono",
		},

		-- Default list of enabled providers defined so that you can extend it
		-- elsewhere in your config, without redefining it, due to `opts_extend`
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
		},
		fuzzy = {
			implementation = "prefer_rust",
		},

		-- Blink.cmp uses a Rust fuzzy matcher by default for typo resistance and significantly better performance
		-- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
		-- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
		--
		-- See the fuzzy documentation for more information
	},
	opts_extend = { "sources.default" },
}

local keymap = vim.keymap.set
-- local keymap = vim.keymap.set

-- vim.keymap.set({ "n", "v" }, "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", { desc = "Code Action" })
-- vim.keymap.set(
-- 	{ "n", "v" },
-- 	"<leader>lf",
-- 	"<cmd>lua vim.lsp.buf.format({async = true, filter = function(client) return client.name ~= 'typescript-tools' end})<cr>",
-- 	{ desc = "Format" }
-- )
-- vim.keymap.set({ "n", "v" }, "<leader>li", "<cmd>LspInfo<cr>", { desc = "Info" })
-- vim.keymap.set({ "n", "v" }, "<leader>lj", "<cmd>lua vim.diagnostic.goto_next()<cr>", { desc = "Next Diagnostic" })
-- vim.keymap.set(
-- 	{ "n", "v" },
-- 	"<leader>lh",
-- 	"<cmd>lua require('user.lspconfig').toggle_inlay_hints()<cr>",
-- 	{ desc = "Hints" }
-- )
-- vim.keymap.set({ "n", "v" }, "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev()<cr>", { desc = "Prev Diagnostic" })
-- vim.keymap.set({ "n", "v" }, "<leader>ll", "<cmd>lua vim.lsp.codelens.run()<cr>", { desc = "CodeLens Action" })
-- vim.keymap.set({ "n", "v" }, "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<cr>", { desc = "Quickfix" })
-- vim.keymap.set({ "n", "v" }, "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", { desc = "Rename" })

-- keymap.set({ "n", "v" }, "<leader>la", "<cmd>lua require('blink.cmp').code_action()<cr>", { desc = "Code Action" })
-- keymap.set(
-- 	{ "n", "v" },
-- 	"<leader>lf",
-- 	"<cmd>lua vim.lsp.buf.format({async = true, filter = function(client) return client.name ~= 'typescript-tools' end})<cr>",
-- 	{ desc = "Format" }
-- )
-- keymap.set({ "n", "v" }, "<leader>li", "<cmd>LspInfo<cr>", { desc = "Info" })
-- keymap.set({ "n", "v" }, "<leader>lj", "<cmd>lua vim.diagnostic.goto_next()<cr>", { desc = "Next Diagnostic" })
-- keymap.set(
--   { "n", "v" },
--   "<leader>lh",
--   "<cmd>lua require('blink.cmp').toggle_inlay_hints()<cr>",
--   { desc = "Hints" }
-- )

function M.opts()
	require("blink.cmp").setup({})
end

return M
