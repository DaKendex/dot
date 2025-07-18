return {
  "pwntester/octo.nvim",
  cmd = "Octo",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    "echasnovski/mini.icons",
  },
  config = function()
    local keymap = vim.keymap.set
    local opts = { noremap = true, silent = true }

    keymap("n", "<leader>O", "<cmd>Octo<CR>", opts)
    require("octo").setup({
      enable_builtin = true,
      suppress_missing_scope = {
        projects_v2 = true,
      },
    })
  end,
}
