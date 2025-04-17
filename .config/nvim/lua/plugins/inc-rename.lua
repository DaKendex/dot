local M = {
  "smjonas/inc-rename.nvim",
}

function M.config()
  require("inc_rename").setup({})
end

vim.keymap.set("n", "<leader>rn", function()
  return ":IncRename " .. vim.fn.expand("<cword>")
end, { expr = true })

return M
