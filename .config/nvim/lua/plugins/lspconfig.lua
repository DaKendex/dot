return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    {
      {
        "ray-x/go.nvim",
        dependencies = {
          "ray-x/guihua.lua",
          "nvim/nvim-lspconfig",
          "nvim-treesitter/nvim-treesitter",
        },
        ft = { "go", "gomod" },
      },
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      { "williamboman/mason-lspconfig.nvim" },
      { "williamboman/mason.nvim", opts = {} },
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
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("nvim-lsp-attach", { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc, mode)
          mode = mode or "n"
          vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        -- Go to navigation
        map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
        map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
        map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
        map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
        map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")

        -- Symbols
        map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
        map(
          "<leader>ws",
          require("telescope.builtin").lsp_dynamic_workspace_symbols,
          "[W]orkspace [S]ymbols"
        )

        -- Actions
        map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
        map("<leader>la", vim.lsp.buf.code_action, "[L]ist [A]ctions", { "n", "x" })
        -- map("<leader>lf", vim.lsp.buf.format, "[L]SP [F]ormat", { "n", "v" })
        map("<leader>lf", function()
          require("conform").format({
            async = false,
            lsp_fallback = true,
          })
        end, "[L]SP [F]ormat", { "n", "v" })

        -- Info and diagnostics
        map("K", vim.lsp.buf.hover, "Hover Documentation")
        map("<leader>li", "<cmd>LspInfo<CR>", "LSP [I]nfo")
        map("gl", vim.diagnostic.open_float, "[G]utter [L]ine Diagnostics")

        -- Optional: Uncomment for inlay hints or conditional formatting
        -- local client = vim.lsp.get_client_by_id(event.data.client_id)
        -- if client.supports_method("textDocument/inlayHint") then
        --   vim.lsp.inlay_hint.enable(true)
        -- end
      end,
    })

    local servers = {
      lua_ls = {
        root_marker = { ".luarc.json", ".luacheckrc", "stylua.toml", ".git" },
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
      },
      bashls = {
        filetypes = { "sh", "zsh" },
      },
      gopls = {
        on_attach = function()
          require("go").setup({})
          -- vim.api.nvim_create_autocmd("BufWritePre", {
          --   pattern = "*.go",
          --   callback = function()
          --     require("conform").format({
          --       bufnr = vim.api.nvim_get_current_buf(),
          --       async = false,
          --       lsp_fallback = true,
          --     })
          --   end,
          --   group = vim.api.nvim_create_augroup("go_format", { clear = true }),
          -- })
        end,
      },
      terraformls = {
        cmd = { "terraform-ls", "serve" },
        root_marker = { ".terraform", ".git" },
        filetypes = {
          "terraform",
          "tf",
          "tfvars",
        },
        -- on_attach = function()
        --   vim.api.nvim_create_autocmd("BufWritePre", {
        --     buffer = vim.api.nvim_get_current_buf(),
        --     callback = function()
        --       require("conform").format({
        --         bufnr = vim.api.nvim_get_current_buf(),
        --         async = false,
        --         lsp_fallback = true,
        --       })
        --     end,
        --     group = vim.api.nvim_create_augroup("tf_format", { clear = true }),
        -- })
        -- end,
      },
      tflint = {},
      jsonls = {
        settings = {
          json = {
            schemas = require("schemastore").json.schemas(),
          },
        },
      },
      yamlls = {
        settings = {
          yaml = {
            schemas = require("schemastore").yaml.schemas(),
            format = { enable = true },
            validate = true,
          },
        },
      },

      groovyls = {
        filetypes = { "groovy", "jenkinsfile" },
        cmd = {
          "java",
          "-jar",
          vim.fn.stdpath("data")
            .. "/mason/packages/groovy-language-server/build/libs/groovy-language-server-all.jar",
        },
        root_marker = { "Jenkinsfile", ".git" },
      },
      eslint = {
        settings = { workingDirectories = { mode = "auto" } },
        filetypes = {
          "javascript",
          "javascriptreact",
          "javascript.jsx",
          "typescript",
          "typescriptreact",
          "typescript.tsx",
        },
      },
      ts_ls = {
        filetypes = {
          "javascript",
          "javascriptreact",
          "javascript.jsx",
          "typescript",
          "typescriptreact",
          "typescript.tsx",
        },
      },
      tailwindcss = {
        filetypes = {
          "astro",
          "javascript",
          "javascriptreact",
          "javascript.jsx",
          "typescript",
          "typescriptreact",
          "typescript.tsx",
        },
      },
      -- ["plantuml-lsp"] = {
      --   cmd = { "plantuml-lsp" },
      --   filetypes = { "plantuml" },
      --   root_marker = { ".git" },
      -- },

      -- harper_ls = {
      --   settings = {
      --     ["harper-ls"] = {
      --       linters = {
      --         SpellCheck = false,
      --         SentenceCapitalization = false,
      --       },
      --     },
      --   },
      --   filetypes = { "gitcommit", "markdown" },
      -- },
      taplo = {},
      omnisharp = {},
      cssls = {},
      html = {},
      pyright = {},
    }

    -- LSP servers and clients are able to communicate to each other what features they support.
    --  By default, Neovim doesn't support everything that is in the LSP specification.
    --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
    --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
    -- local original_capabilities = vim.lsp.protocol.make_client_capabilities()
    -- local capabilities = require("blink.cmp").get_lsp_capabilities(original_capabilities)
    -- capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

    require("mason").setup()
    require("mason-lspconfig").setup({
      automatic_enable = vim.tbl_keys(servers),
    })
    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, {
      "bashls",
      "cssls",
      "eslint",
      "eslint",
      "goimports-reviser",
      "golines",
      "gopls",
      "groovyls",
      "html",
      "jsonls",
      "lua_ls",
      "omnisharp",
      "pyright",
      "shfmt",
      "tailwindcss",
      "taplo",
      "terraformls",
      "tflint",
      "ts_ls",
      "yamlls",
      -- "harper_ls", -- Disabled due to issues with the server
    })
    require("mason-tool-installer").setup({
      ensure_installed = ensure_installed,
    })
    for server_name, config in pairs(servers) do
      vim.lsp.config(server_name, config)
    end
  end,
}
