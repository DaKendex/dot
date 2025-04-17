return {
  "mbbill/undotree",
  cmd = { "UndotreeToggle" },

  vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { noremap = true, silent = true }),
}
