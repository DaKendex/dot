local M = {
  "kdheepak/lazygit.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-lua/plenary.nvim",
  }
}

function M.config() 
  local icons = require "user.icons"
  local wk = require "which-key"
  wk.register {
    ["<leader>gg"] = { "<cmd>LazyGit<CR>", "LazyGit"},
  }
end

return M
