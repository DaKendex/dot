return {
  "axieax/urlview.nvim",
  event = "BufRead",
  config = function()
    require("urlview").setup({
      default_picker = "telescope",
    })
  end,
  vim.keymap.set("n", "<leader>U", "<cmd>UrlView<cr>", { desc = "Open UrlView" }),
}
