return {
  "andrewferrier/debugprint.nvim",
  opts = {},
  dependencies = {
    "ibhagwan/fzf-lua",            -- Optional: If you want to use the `:Debugprint search` command with fzf-lua
    "nvim-telescope/telescope.nvim", -- Optional: If you want to use the `:Debugprint search` command with telescope.nvim
  },
  lazy = false,                    -- Required to make line highlighting work before debugprint is first used
  version = "*",                   -- Remove if you DON'T want to use the stable version
}
