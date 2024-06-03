local M = { "mistricky/codesnap.nvim", build = "make" }

function M.config() require("codesnap").setup({

  has_breadcrumbs = true,
  watermark = "DaKendex",

  vim.keymap.set("x", "<leader>cc", "<cmd>CodeSnap<cr>", { desc = "Save selected code snapshot into clipboard"})
}) end

return M
