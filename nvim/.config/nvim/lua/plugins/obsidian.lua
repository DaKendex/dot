local M = {
	"epwalsh/obsidian.nvim",
	version = "v3.7.12",
  event = {
    "BufReadPre " .. vim.fn.expand "~" .. "/repo/obsidian/**.md",
    "BufNewFile " .. vim.fn.expand "~" .. "/repo/obsidian/**.md",
  },
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
}

function M.config()
	require("obsidian").setup({
		workspaces = {
			{
				name = "obsidian",
				path = "~/repo/obsidian",
			},
		},
    templates = {
      {
        folder = "templates",
      },
    },
		daily_notes = {
			-- Optional, if you keep daily notes in a separate directory.
			folder = "timestamps/",
			-- Optional, if you want to change the date format for the ID of daily notes.
			date_format = "%Y/%m/%d",
			-- Optional, if you want to change the date format of the default alias of daily notes.
			-- alias_format = "%B %-d, %Y",
			-- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
      templates = {
        {
          folder = "templates/daily.md",
        },
      },
			-- template = "./templates/daily.md",
      default_tags = { "daily" },
		},
		ui = {
			enabled = false,
		},
	})
end

return M
