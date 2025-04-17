local M = {
  "nvim-lualine/lualine.nvim",
  event = "BufWinEnter",
  dependencies = {
    "AndreM222/copilot-lualine",
  },
}

function M.config()
  require("lualine").setup({
    options = {
      -- theme = bubbles_theme,
      theme = "catppuccin",
      component_separators = "",
      section_separators = { left = "", right = "" },
      icons_enabled = true,
      ignore_focus = { "NvimTree" },
    },
    sections = {
      lualine_a = { { "mode", separator = { left = "" }, right_padding = 2 } },
      lualine_b = { "branch" },
      lualine_c = { "filename" },
      lualine_x = {
        { "copilot", show_colors = true },
      },
      lualine_y = { "filetype", "progress" },
      lualine_z = {
        { "location", separator = { right = "" }, left_padding = 2 },
      },
    },
    extensions = { "quickfix", "man", "fugitive" },
  })
end

return M
