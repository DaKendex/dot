
------------------------
-- Plugins
------------------------
lvim.plugins = {
  {"olexsmir/gopher.nvim"},
  {"leoluz/nvim-dap-go"},
  {"tpope/vim-surround"},
  {"christoomey/vim-tmux-navigator"},
  {
    "folke/todo-comments.nvim",
    event = "BufRead",
    config = function()
      require("todo-comments").setup()
    end
  },
  {
    "phaazon/hop.nvim",
    branch = 'v2',
    config = function()
      require('hop').setup()
    end
  },
  {
    "folke/zen-mode.nvim",
  },
  {
  "tpope/vim-fugitive",
  cmd = {
    "G",
    "Git",
    "Gdiffsplit",
    "Gread",
    "Gwrite",
    "Ggrep",
    "GMove",
    "GDelete",
    "GBrowse",
    "GRemove",
    "GRename",
    "Glgrep",
    "Gedit"
  },
  ft = {"fugitive"}
  },
  {
    "tpope/vim-rhubarb",
  }
}
