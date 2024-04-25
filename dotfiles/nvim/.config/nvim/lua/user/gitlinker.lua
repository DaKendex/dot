local M = {
  "linrongbin16/gitlinker.nvim",
  dependencies = { { "nvim-lua/plenary.nvim" } },
  event = "VeryLazy",
}
-- GitLink: generate git link and copy to clipboard.
-- GitLink!: generate git link and open in browser.
-- GitLink blame: generate the /blame url and copy to clipboard.
-- GitLink! blame: generate the /blame url and open in browser.

function M.config()
  local wk = require "which-key"
  wk.register {
    ["<leader>gy"] = { "<cmd>GitLink<cr>", "Git link" },
    ["<leader>gY"] = { "<cmd>GitLink!<cr>", "Open link" },
    ["<leader>gb"] = { "<cmd>GitLink blame<cr>", "Git link blame" },
    ["<leader>gB"] = { "<cmd>GitLink! blame<cr>", "Open Git blame link" },
  }

  require("gitlinker").setup {
    console_log = true,
  --   callbacks = {
  --     ["git.cioxhealth.com"] = require"gitlinker.hosts".get_gitlab_type_url
  --   }
  }
end

return M
