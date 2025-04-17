local M = {
  "LunarVim/bigfile.nvim",
  event = "VeryLazy",
}

function M.config()
  require("bigfile").setup()
end

return M
