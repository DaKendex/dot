local M = {
  "epwalsh/obsidian.nvim",
  event = {
    "BufReadPre " .. vim.fn.expand("~") .. "/repo/obsidian/**.md",
    "BufNewFile " .. vim.fn.expand("~") .. "/repo/obsidian/**.md",
  },
  cmd = {
    "ObsidianOpen",
    "ObsidianNew",
    "ObsidianQuickSwitch",
    "ObsidianFollowLink",
    "ObsidianBacklinks",
    "ObsidianToday",
    "ObsidianYesterday",
    "ObsidianTemplate",
    "ObsidianSearch",
    "ObsidianLink",
    "ObsidianLinkNew",
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
}

-- Noon anchoring keeps the day arithmetic correct across DST boundaries.
local function offset_date(days)
  local t = os.date("*t")
  t.hour, t.min, t.sec = 12, 0, 0
  t.day = t.day + days
  return os.date("%Y-%m-%d", os.time(t))
end

function M.config()
  require("obsidian").setup({
    workspaces = {
      {
        name = "obsidian",
        path = "~/repo/obsidian",
      },
    },
    templates = {
      folder = "templates",
      -- Core Obsidian resolves {{yesterday}}/{{tomorrow}} natively; obsidian.nvim does not.
      substitutions = {
        yesterday = function()
          return offset_date(-1)
        end,
        tomorrow = function()
          return offset_date(1)
        end,
      },
    },
    daily_notes = {
      -- Optional, if you keep daily notes in a separate directory.
      folder = "daily/",
      -- Optional, if you want to change the date format for the ID of daily notes.
      date_format = "%Y-%m-%d",
      -- Optional, if you want to change the date format of the default alias of daily notes.
      -- alias_format = "%B %-d, %Y",
      -- Template file name, resolved inside the templates folder above.
      template = "daily.md",
      default_tags = { "daily" },
    },
    ui = {
      enabled = false,
    },
  })
end

return M
