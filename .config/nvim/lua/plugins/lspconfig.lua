local M = {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		{
			{
				"folke/lazydev.nvim",
				ft = "lua", -- only load on lua files
				opts = {
					library = {
						-- See the configuration section for more details
						-- Load luvit types when the `vim.uv` word is found
						{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
					},
				},
			},
			{ "williamboman/mason-lspconfig.nvim" },
			{ "williamboman/mason.nvim" },
			-- { "hrsh7th/cmp-nvim-lsp" },
			{
				"j-hui/fidget.nvim",
				opts = {
					notification = {
						window = {
							winblend = 0,
							align = "top",
						},
					},
				},
			},
			"saghen/blink.cmp",
		},
	},
}

vim.lsp.set_log_level("off")

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local function lsp_keymaps(bufnr)
	local opts = { noremap = true, silent = true }
	local keymap = vim.api.nvim_buf_set_keymap
	keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	keymap(bufnr, "n", "gd", "<cmd>lua require('telescope.builtin').lsp_definitions()<CR>zz", opts)
	keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	keymap(bufnr, "n", "gI", "<cmd>lua require('telescope.builtin').lsp_implementations()<CR>", opts)
	keymap(bufnr, "n", "gr", "<cmd>lua require('telescope.builtin').lsp_references()<CR>", opts)
	keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
  keymap(bufnr, "n", "<leader>ds", "<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>", opts)
end
M.on_attach = function(client, bufnr)
	lsp_keymaps(bufnr)
	if client.supports_method("textDocument/inlayHint") then
		vim.lsp.inlay_hint.enable(true)
	end
	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_clear_autocmds({
			group = augroup,
		})
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = augroup,
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.format({ bufnr = bufnr })
			end,
		})
	end
end

M.toggle_inlay_hints = function()
	local bufnr = vim.api.nvim_get_current_buf()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr }))
end

function M.config()
	vim.keymap.set({ "n", "v" }, "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", { desc = "Code Action" })
	vim.keymap.set(
		{ "n", "v" },
		"<leader>lf",
		"<cmd>lua vim.lsp.buf.format({async = true, filter = function(client) return client.name ~= 'typescript-tools' end})<cr>",
		{ desc = "Format" }
	)
	vim.keymap.set({ "n", "v" }, "<leader>li", "<cmd>LspInfo<cr>", { desc = "Info" })
	vim.keymap.set({ "n", "v" }, "<leader>lj", "<cmd>lua vim.diagnostic.goto_next()<cr>", { desc = "Next Diagnostic" })
	vim.keymap.set(
		{ "n", "v" },
		"<leader>lh",
		"<cmd>lua require('lspconfig').toggle_inlay_hints()<cr>",
		{ desc = "Hints" }
	)
	vim.keymap.set({ "n", "v" }, "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev()<cr>", { desc = "Prev Diagnostic" })
	vim.keymap.set({ "n", "v" }, "<leader>ll", "<cmd>lua vim.lsp.codelens.run()<cr>", { desc = "CodeLens Action" })
	vim.keymap.set({ "n", "v" }, "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<cr>", { desc = "Quickfix" })
	vim.keymap.set({ "n", "v" }, "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", { desc = "Rename" })

	local servers = {
		"lua_ls",
		"cssls",
		"html",
		"eslint",
		"pyright",
		"bashls",
		"jsonls",
		"yamlls",
		"terraformls",
		"gopls",
		"omnisharp",
	}

	-- LSP servers and clients are able to communicate to each other what features they support.
	--  By default, Neovim doesn't support everything that is in the LSP specification.
	--  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
	--  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
	local original_capabilities = vim.lsp.protocol.make_client_capabilities()
	local capabilities = require("blink.cmp").get_lsp_capabilities(original_capabilities)
	-- capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

	local lspconfig = require("lspconfig")
	local lspHandlers = {
		function(server_name)
			require("lspconfig")[server_name].setup({
				on_attach = M.on_attach,
				capabilities = capabilities,
			})
		end,

		["lua_ls"] = function()
			lspconfig.lua_ls.setup({
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			})
		end,

		["gopls"] = function()
			lspconfig.gopls.setup({
				cmd = { "gopls", "serve" },
				filetypes = { "go", "gomod", "gowork", "gotmpl" },
				settings = {
					gopls = {
						completeUnimported = true,
						usePlaceholders = true,
						analyses = {
							unusedparams = true,
							unreachable = false,
						},
					},
				},
			})
		end,

		["terraformls"] = function()
			lspconfig.terraformls.setup({
				cmd = { "terraform-ls", "serve" },
				root_dir = lspconfig.util.root_pattern(".terraform", ".git"),
			})
		end,
	}

	require("mason").setup()
	require("mason-lspconfig").setup({
		ensure_installed = servers,
		automatic_installation = true,
		handlers = lspHandlers,
	})

	local lspIcons = require("user.icons").diagnostics
	vim.diagnostic.config({
		severity_sort = true,
		float = { border = "rounded", source = "if_many" },
		underline = { severity = vim.diagnostic.severity.ERROR },
		signs = {
			text = {
				[vim.diagnostic.severity.ERROR] = lspIcons.Error,
				[vim.diagnostic.severity.WARN] = lspIcons.Warning,
				[vim.diagnostic.severity.INFO] = lspIcons.Information,
				[vim.diagnostic.severity.HINT] = lspIcons.Hint,
			},
		},
		virtual_text = {
			source = "if_many",
			spacing = 2,
			format = function(diagnostic)
				local diagnostic_message = {
					[vim.diagnostic.severity.ERROR] = diagnostic.message,
					[vim.diagnostic.severity.WARN] = diagnostic.message,
					[vim.diagnostic.severity.INFO] = diagnostic.message,
					[vim.diagnostic.severity.HINT] = diagnostic.message,
				}
				return diagnostic_message[diagnostic.severity]
			end,
		},
	})
end

return M
