local M = {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
}

function M.config()
  require("tokyonight").setup({
    style = "storm",
    transparent = true,
    styles = {
      comments = "italic",
      -- functions = "italic",
      -- keywords = "italic",
      -- strings = "italic",
      -- variables = "italic",
    }
  })
  vim.cmd.colorscheme("tokyonight")
end

return M
