local M = {
  "nvim-treesitter/nvim-treesitter-context",
  event = { "BufReadPost", "BufNewFile" },
}

function M.config()
  require("treesitter-context").setup({})
end

return M
