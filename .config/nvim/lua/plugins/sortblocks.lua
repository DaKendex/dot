return {
  "sortblocks",                                               -- pseudo name, doesn't fetch from remote
  enabled = false,
  dir = vim.fn.stdpath("config") .. "/lua/plugins/sortblocks", -- local plugin path
  lazy = false,
  config = function()
    require("plugins.sortblocks").setup()
  end,
}
