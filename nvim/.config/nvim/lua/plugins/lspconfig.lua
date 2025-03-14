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
      { "hrsh7th/cmp-nvim-lsp" },
      { "j-hui/fidget.nvim" },
      -- "saghen/blink.cmp",
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

  local cmp_lsp = require("cmp_nvim_lsp")
  local capabilities = vim.tbl_deep_extend(
    "force",
    {},
    vim.lsp.protocol.make_client_capabilities(),
    cmp_lsp.default_capabilities()
  )

  local lspconfig = require("lspconfig")
  local lspHandlers = {
    function(server_name)
      require("lspconfig")[server_name].setup {
        on_attach = M.on_attach,
        capabilities = capabilities,

      }
    end,

    ["lua_ls"] = function()
      lspconfig.lua_ls.setup {
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" }
            }
          }
        }
      }
    end,

    ["gopls"] = function()
      lspconfig.gopls.setup {
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
      }
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
    virtual_text = {
      virt_text_pos = "eol",
      prefix = "",
      format = function(diagnostic)
        local icons = {
          [vim.diagnostic.severity.ERROR] = lspIcons.Error,
          [vim.diagnostic.severity.WARN] = lspIcons.Warning,
          [vim.diagnostic.severity.INFO] = lspIcons.Information,
          [vim.diagnostic.severity.HINT] = lspIcons.Hint,
        }
        return string.format("%s %s", icons[diagnostic.severity], diagnostic.message)
      end,
    },
    signs = { text = { ERROR = "", WARN = "", INFO = "", HINT = "" } },
  })
end

return M
