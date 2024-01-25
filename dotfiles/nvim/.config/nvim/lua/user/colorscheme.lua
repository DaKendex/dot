local M = {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
}

function M.config()
  require("tokyonight").setup({
    style = "night",
  })
  vim.cmd.colorscheme("tokyonight")
end

return M
