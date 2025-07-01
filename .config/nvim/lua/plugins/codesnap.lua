local M = {
  "mistricky/codesnap.nvim",
  build = "make",
  command = "CodeSnap",
  event = "BufRead",
}

function M.config()
  require("codesnap").setup({

    bg_color = "#1f2335",
    has_breadcrumbs = true,
    watermark = "DaKendex",

    vim.keymap.set(
      "x",
      "<leader>cc",
      "<cmd>CodeSnap<cr>",
      { desc = "Save selected code snapshot into clipboard" }
    ),
  })
end

return M
