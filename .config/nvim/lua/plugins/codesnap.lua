local M = {
  "mistricky/codesnap.nvim",
  build = "make",
  cmd = "CodeSnap",
  keys = {
    { "<leader>cc", "<cmd>CodeSnap<cr>", mode = "x", desc = "Save selected code snapshot into clipboard" },
  },
}

function M.config()
  require("codesnap").setup({
    bg_color = "#1f2335",
    has_breadcrumbs = true,
    watermark = "DaKendex",
  })
end

return M
