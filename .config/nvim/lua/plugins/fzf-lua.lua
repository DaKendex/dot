return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  -- or if using mini.icons/mini.nvim
  -- dependencies = { "echasnovski/mini.icons" },
  -- opts = function()
  --   local actions = require("fzf-lua.actions")
  --   return {
  --     fzf_opts = {
  --       ["--info"] = "default",
  --       ["--layout"] = "default",
  --     },
  --     helptags = {
  --       actions = {
  --         -- Open help pages in a vertical split.
  --         ["enter"] = actions.help_vert,
  --       },
  --     },
  --     keymap = {
  --       builtin = {
  --         ["<C-/>"] = "toggle-help",
  --         ["<C-d>"] = "preview-page-down",
  --         ["<C-u>"] = "preview-page-up",
  --       },
  --     },
  --   }
  -- end,
  keys = {
    { "<leader>f.", "<cmd>FzfLua resume<cr>",                    desc = "Resume last command" },
    {
      "<leader>ff",
      function()
        require("fzf-lua").files()
      end,
      desc = "Find Files in project directory",
    },
    {
      "<leader>fF",
      function()
        require("fzf-lua").files({ cwd = vim.fn.expand("%:p:h") })
      end,
      desc = "Find files in Root Dir",
    },
    -- { "<leader>fR", function()
    --   require("fzf-lua").oldfiles({ cwd = vim.fn.expand("%:p:h") })
    -- end,     desc = "Recent File in Root Dir" },
    {
      "<leader>fg",
      function()
        require("fzf-lua").live_grep()
      end,
      desc = "Find by grepping in project directory",
    },
    {
      "<leader>ft",
      --live grep in the root dir
      function()
        require("fzf-lua").live_grep({ cwd = vim.fn.expand("%:p:h") })
      end,
      desc = "Live Grep in Current Dir",
    },
    {
      "<leader>fT",
      --live grep in the root dir
      function()
        require("fzf-lua").live_grep()
      end,
      desc = "Live Grep in Root Dir",
    },
    { "<leader>fd", "<cmd>FzfLua lsp_document_diagnostics<cr>",  desc = "Document diagnostics" },
    { "<leader>fD", "<cmd>FzfLua lsp_workspace_diagnostics<cr>", desc = "Workspace diagnostics" },
    -- {
    --   "<leader>ps",
    --   function()
    --     require("fzf-lua").grep({ search = vim.fn.input("Grep for > "), cwd = vim.fn.expand("%:p:h") })
    --   end,
    --   desc = "Find files",
    -- },
    {
      "<leader>ps",
      function()
        require("fzf-lua").grep_cword({ cwd = vim.fn.expand("%:p:h") })
      end,
      desc = "Grep Word",
    },
    {
      "<leader>pS",
      function()
        require("fzf-lua").grep_cword()
      end,
      desc = "Grep Word",
    },
    { "<leader>fh", "<cmd>FzfLua help_tags<cr>", desc = "Help" },
    { "<leader>fr", "<cmd>FzfLua oldfiles<cr>",  desc = "Recent File" },
    { "<leader>fl", "<cmd>FzfLua resume<cr>",    desc = "Last Search" },
    { "<leader>fk", "<cmd>FzfLua keymaps<cr>",   desc = "Keymaps" },
  },
  config = function()
    local actions = require("fzf-lua.actions")
    require("fzf-lua").setup({
      fzf_opts = {
        ["--info"] = "default",
        ["--layout"] = "default",
      },
      keymap = {
        fzf = {
          ["ctrl-q"] = "select-all+accept",
        },
        helptags = {
          actions = {
            -- Open help pages in a vertical split.
            ["enter"] = actions.help_vert,
          },
        },
      },
    })
  end,
}
