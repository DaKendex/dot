local M = {
  "LunarVim/bigfile.nvim",
}

function M.config()
  require("bigfile").setup()
end

return M
