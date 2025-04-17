local M = {
  "topaxi/pipeline.nvim",
  build = "make",
}

function M.config()
  require("pipeline").setup({})
end

vim.keymap.set({ "n", "v" }, "<leader>ci", "<cmd>Pipeline<cr>", { desc = "Open pipeline.nvim" })

return M
