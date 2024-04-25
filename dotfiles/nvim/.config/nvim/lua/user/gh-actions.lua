local M = {
  "topaxi/gh-actions.nvim",
  cmd = 'GhActions',
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
  },
}

vim.keymap.set("n", "<leader>gh", "<cmd>GhActions<cr>",  { desc = "Open Github Actions", noremap = true, silent = true })

function M.config()
  -- local wk = require "which-key"
  -- wk.register {
  --   ["<leader>gh"] = { "<cmd>GhActions<cr>", "Open GitHub Actions" },
  -- }
  require("gh-actions").setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    -- browser = "/Applications/Arc.app",
  }
end

return M
