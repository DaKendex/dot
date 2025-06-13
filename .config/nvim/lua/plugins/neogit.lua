return {
  "NeogitOrg/neogit",
  cmd = "Neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",         -- required
    "sindrets/diffview.nvim",        -- optional - Diff integration
    "nvim-telescope/telescope.nvim", -- optional
  },
  config = true,
  vim.keymap.set("n", "<leader>gs", "<cmd>Neogit<CR>", { silent = true, noremap = true }),
  vim.keymap.set("n", "<leader>gc", "<cmd>Neogit commit<CR>", { silent = true, noremap = true }),
  vim.keymap.set("n", "<leader>gp", "<cmd>Neogit pull<CR>", { silent = true, noremap = true }),
  vim.keymap.set("n", "<leader>gP", "<cmd>Neogit push<CR>", { silent = true, noremap = true }),
  vim.keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<CR>", { silent = true, noremap = true }),
  vim.keymap.set("n", "<leader>gB", "<cmd>G blame<CR>", { silent = true, noremap = true }),
}
