return {
  "stevearc/oil.nvim",
  dependencies = "echasnovski/mini.icons",

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
    vim.keymap.set(
      "n",
      "-",
      "<CMD>lua require('oil').open_float()<CR>",
      { desc = "Open parent directory" }
    )
  end,
}
