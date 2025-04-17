local M = {
  "jonahgoldwastaken/copilot-status.nvim",
  dependencies = {
    "zbirenbaum/copilot.lua",
    -- "github/copilot.vim",
  },
  lazy = true,
  event = "BufReadPost",
}

function M.config()
  require("copilot_status").setup({
    icons = {
      idle = " ",
      error = " ",
      offline = " ",
      warning = "𥉉 ",
      loading = " ",
    },
    debug = false,
  })
end

return M
