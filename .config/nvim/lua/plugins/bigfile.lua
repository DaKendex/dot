local M = {
  "LunarVim/bigfile.nvim",
  event = "InsertEnter",
}

function M.config()
  require("bigfile").setup()
end

return M
