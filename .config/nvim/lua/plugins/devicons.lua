local M = {
  "nvim-tree/nvim-web-devicons",
  event = "VeryLazy",
  enabled = false,
}

function M.config()
  require("nvim-web-devicons")
end

return M
