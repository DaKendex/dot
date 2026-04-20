local M = {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  ft = { "markdown" },
  build = "cd app && yarn install",
  init = function()
    vim.g.mkdp_filetypes = { "markdown" }
  end,
}

function M.config() end

vim.keymap.set(
  "n",
  "<leader>md",
  "<cmd>MarkdownPreviewToggle<cr>",
  { desc = "Markdown Preview Toggle", noremap = true, silent = true }
)
return M
