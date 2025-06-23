return {
  "sQVe/sort.nvim",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    require("sort").setup({})
  end,
  vim.keymap.set({ "n", "v" }, "<leader>ss", "<CMD>Sort<CR>", { desc = "Sort lines" }),
}
