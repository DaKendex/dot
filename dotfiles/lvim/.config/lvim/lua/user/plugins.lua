
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
}
