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
      {
        icon = icons.ui.Files,
        key = "f",
        desc = "Find File",
        action = ":Telescope find_files",
      },
      { icon = icons.ui.Search, key = "t", desc = "Live Grep", action = ":Telescope live_grep" },
      { icon = icons.ui.Telescope, key = "h", desc = "Help", action = ":Telescope help_tags" },
      { icon = icons.ui.History, key = "s", desc = "Restore Session", section = "session" },
      {
        icon = icons.git.Branch,
        key = "g",
        desc = "LazyGit",
        action = function()
          require("snacks").lazygit()
        end,
      },
      {
        icon = icons.ui.Gear,
        key = "c",
        desc = "Config",
        action = ":e ~/.config/nvim/init.lua",
      },
      {
        icon = icons.misc.Package,
        key = "L",
        desc = "Lazy",
        action = ":Lazy",
        enabled = package.loaded.lazy,
      },
      { icon = icons.ui.Quit, key = "q", desc = "Quit", action = ":qa" },
    }

    return {
      git = { enabled = true },
      lazygit = {
        enabled = true,
        configure = false,
      },
      dashboard = {
        width = 80,
        row = nil,
        col = nil,
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
          function()
            local in_git = Snacks.git.get_root() ~= nil
            local cmds = {
              {
                pane = 2,
                title = "Notifications",
                cmd = "gh notify -s -a -n5",
                action = function()
                  vim.ui.open("https://github.com/notifications")
                end,
                key = "n",
                icon = icons.ui.Bell,
                height = 5,
              },
              {
                pane = 2,
                icon = " ",
                title = "Open PRs",
                cmd = "gh pr list -L 3",
                key = "p",
                action = function()
                  vim.fn.jobstart("gh pr list --web", { detach = true })
                end,
                height = 7,
              },
              {
                pane = 2,
                icon = icons.git.Branch,
                title = "Git Status",
                section = "terminal",
                cmd = "git status --short --branch --renames",
                -- height = 5,
                -- padding = 1,
                -- ttl = 5 * 60,
                -- indent = 3,
              },
            }
            return vim.tbl_map(function(cmd)
              return vim.tbl_extend("force", {
                pane = 2,
                section = "terminal",
                enabled = in_git,
                padding = 1,
                ttl = 5 * 60,
                indent = 3,
              }, cmd)
            end, cmds)
          end,
          { section = "startup" },
        },
      },
    }
  end,

  vim.keymap.set({ "n", "v" }, "<leader>gg", function()
    require("snacks").lazygit()
  end, { desc = "[G]it: LazyGit" }),
}
