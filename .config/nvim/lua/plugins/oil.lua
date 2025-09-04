return {
  "benomahony/oil-git.nvim",
  dependencies = {
    "stevearc/oil.nvim",
    -- dependencies = "echasnovski/mini.icons",

    config = function()
      require("oil").setup({
        columns = { "icon" },
        float = {
          preview_split = "right",
        },
        keymaps = {
          ["<S-h>"] = "actions.select_split",
          ["<leader>o"] = "<CMD>exec '!open ' . expand('%:p')[6:]<CR>",
        },
        view_options = {
          show_hidden = true,
        },
      })

      local map = function(keys, func, desc, mode)
        mode = mode or { "n" }
        vim.keymap.set(mode, keys, func, { desc = "Oil: " .. desc })
      end
      map("-", "<CMD>lua require('oil').open_float()<CR>", "Open parent directory")
    end,
  },
}
