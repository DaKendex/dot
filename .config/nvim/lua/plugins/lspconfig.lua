return {
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

  config = function()
    -- LSP keymaps on attach
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc, mode)
          mode = mode or 'n'
          vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        -- Go to navigation
        map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
        map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
        map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
        map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
        map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

        -- Symbols
        map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
        map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

        -- Actions
        map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
        map('<leader>la', vim.lsp.buf.code_action, '[L]ist [A]ctions', { 'n', 'x' })
        map('<leader>lf', vim.lsp.buf.format, '[L]SP [F]ormat', { 'n', 'v' })

        -- Info and diagnostics
        map('K', vim.lsp.buf.hover, 'Hover Documentation')
        map('<leader>li', '<cmd>LspInfo<CR>', 'LSP [I]nfo')
        map('gl', vim.diagnostic.open_float, '[G]utter [L]ine Diagnostics')

        -- Optional: Uncomment for inlay hints or conditional formatting
        -- local client = vim.lsp.get_client_by_id(event.data.client_id)
        -- if client.supports_method("textDocument/inlayHint") then
        --   vim.lsp.inlay_hint.enable(true)
        -- end
      end,
    })

    -- Format on save
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = vim.api.nvim_create_augroup("Format", { clear = true }),
      callback = function()
        if vim.lsp.get_clients() then
          vim.lsp.buf.format({ async = false })
        end
      end,
    })

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
      "tflint",
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
          -- on_attach = on_attach,
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
              runtime = {
                version = "LuaJIT",
              },
            },
            workspace = {
              checkThirdParty = false,
              library = {
                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                [vim.fn.stdpath("config") .. "/lua"] = true,
              },
            },
          },
        })
      end,

      -- ["gopls"] = function()
      -- 	lspconfig.gopls.setup({
      -- 		cmd = { "gopls", "serve" },
      -- 		filetypes = { "go", "gomod", "gowork", "gotmpl" },
      -- 		settings = {
      -- 			gopls = {
      -- 				completeUnimported = true,
      -- 				usePlaceholders = true,
      -- 				analyses = {
      -- 					unusedparams = true,
      -- 					unreachable = false,
      -- 				},
      -- 			},
      -- 		},
      -- 	})
      -- end,

      ["terraformls"] = function()
        lspconfig.terraformls.setup({
          cmd = { "terraform-ls", "serve" },
          root_dir = lspconfig.util.root_pattern(".terraform", ".git"),
        })
      end,
      ["tflint"] = function()
        lspconfig.tflint.setup({})
      end,

      ["yamlls"] = function()
        lspconfig.yamlls.setup({
          settings = {
            yaml = {
              schemas = require("schemastore").yaml.schemas(),
              format = { enable = true },
              validate = true,
            },
          },
        })
      end,

      ["jsonls"] = function()
        lspconfig.jsonls.setup({
          settings = {
            json = {
              schemas = require("schemastore").json.schemas(),
            },
          },
        })
      end,
    }

    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = servers,
      automatic_installation = true,
      handlers = lspHandlers,
    })
  end,

}
