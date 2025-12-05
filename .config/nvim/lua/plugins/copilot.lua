local M = {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
}

function M.config()
  require("copilot").setup({
    panel = {
      keymap = {
        jump_next = "<c-j>",
        jump_prev = "<c-k>",
        accept = "<c-l>",
        refresh = "r",
        open = "<M-CR>",
      },
    },
    suggestion = {
      enabled = true,
      auto_trigger = true,
      keymap = {
        accept = "<TAB>",
        next = "<c-n>",
        prev = "<c-p>",
        dismiss = "<c-h>",
      },
    },
    filetypes = {
      yaml = true,
      markdown = true,
      --   help = false,
      --   gitcommit = false,
      --   gitrebase = false,
      --   cvs = false,
      --   ["."] = false,
    },
    copilot_node_command = "node",
  })

  local opts = { noremap = true, silent = true }
  vim.api.nvim_set_keymap(
    "n",
    "<c-s>",
    ":lua require('copilot.suggestion').toggle_auto_trigger()<CR>",
    opts
  )
end

return M
