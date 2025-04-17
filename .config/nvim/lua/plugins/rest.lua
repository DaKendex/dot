local M = {
  "rest-nvim/rest.nvim",
  cmd = "RestNvim",
  depends = "nvim-lua/plenary.nvim",
}

M.config = function()
  require("rest-nvim").setup({
    result = {
      show_url = true,
      show_http_info = true,
      show_headers = true,
    },
    env_file = ".env",
  })
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = "http",
  callback = function()
    local buff = tonumber(vim.fn.expand("<abuf>"), 10)
    vim.keymap.set("n", "<leader>rn", "<CMD>RestNvim<CR>", { noremap = true, buffer = buff })
    vim.keymap.set("n", "<leader>rl", "<CMD>RestNvimLast<CR>", { noremap = true, buffer = buff })
    vim.keymap.set("n", "<leader>rp", "<CMD>RestNvimPreview<CR>", { noremap = true, buffer = buff })
  end,
})

return M
