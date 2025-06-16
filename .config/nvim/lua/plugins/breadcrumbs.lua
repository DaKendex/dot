local M = {
  "utilyre/barbecue.nvim",
  name = "barbecue",
  event = "BufEnter",
  version = "*",
  dependencies = {
    "SmiteshP/nvim-navic",
    { 'echasnovski/mini.icons', opts = {}, version = false },
  },
}

function M.config()
  require("barbecue").setup()
end

return M
