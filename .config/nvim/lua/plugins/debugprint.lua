return {
  "andrewferrier/debugprint.nvim",
  opts = {},
  dependencies = {
    "ibhagwan/fzf-lua", -- Optional: If you want to use the `:Debugprint search` command with fzf-lua
    "nvim-telescope/telescope.nvim", -- Optional: If you want to use the `:Debugprint search` command with telescope.nvim
  },
  cmd = { "Debugprint", "DebugprintSearch" }, -- Commands to load this plugin
  version = "*", -- Remove if you DON'T want to use the stable version
}
