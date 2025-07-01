return {
  "folke/snacks.nvim",
  opts = function()
    local logo = [[
________            ____  __.                 .___              
\______ \ _____    |    |/ _|____   ____    __| _/____ ___  ___ 
 |    |  \\__  \   |      <_/ __ \ /    \  / __ |/ __ \\  \/  / 
 |    `   \/ __ \_ |    |  \  ___/|   |  \/ /_/ \  ___/ >    <  
/_______  (____  / |____|__ \___  >___|  /\____ |\___  >__/\_ \ 
        \/     \/          \/   \/     \/      \/    \/      \/ ]]

    local icons = require("user.icons")

    local keys = {
      { icon = " ", key = "f", desc = "Find File", action = ":Telescope find_files" },
      -- live grep text
      { icon = " ", key = "t", desc = "Live Grep", action = ":Telescope live_grep" },
      { icon = " ", key = "h", desc = "Help", action = ":Telescope help_tags" },
      { icon = " ", key = "s", desc = "Restore Session", section = "session" },
      {
        icon = icons.git.Branch,
        key = "g",
        desc = "LazyGit",
        action = function()
          require("snacks").lazygit()
        end,
      },
      {
        icon = " ",
        key = "c",
        desc = "Config",
        action = ":e ~/.config/nvim/init.lua",
      },
      { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy },
      { icon = " ", key = "q", desc = "Quit", action = ":qa" },
    }

    return {
      git = { enabled = true },
      lazygit = {
        enabled = true,
        configure = false,
      },
      dashboard = {
        width = 80,
        row = nil, -- dashboard position. nil for center
        col = nil, -- dashboard position. nil for center
        enabled = true,
        pane_gap = 4,
        preset = {
          header = logo,
          keys = keys,
        },
        sections = {
          { section = "header" },
          { section = "keys", padding = 1, gap = 1 },
          {
            pane = 2,
            icon = icons.kind.File,
            title = "Recent Files",
            section = "recent_files",
            indent = 2,
            padding = 1,
          },
          {
            pane = 2,
            icon = " ",
            title = "Git Status",
            section = "terminal",
            enabled = function()
              return Snacks.git.get_root() ~= nil
            end,
            cmd = "git status --short --branch --renames",
            -- height = 5,
            -- padding = 1,
            -- ttl = 5 * 60,
            -- indent = 3,
          },
          { section = "startup" },
        },
      },
    }
  end,

  vim.keymap.set({ "n", "v" }, "<leader>gg", function()
    require("snacks").lazygit()
  end, { desc = "LazyGit" }),
}
