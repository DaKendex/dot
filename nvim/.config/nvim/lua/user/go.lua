local M = {
  "ray-x/go.nvim",
  dependencies = {
    "ray-x/guihua.lua",
    "neavim/nvim-lspconfig",
    "nvim-treesitter/nvim-treesitter",
  },
  event = {"CmdlineEnter"},
  ft = {"go", "gomod"},
}
-- Run gofmt + goimports on save

-- local format_sync_grp = vim.api.nvim_create_augroup("goimports", {})
-- vim.api.nvim_create_autocmd("BufWritePre", {
--   pattern = "*.go",
--   callback = function()
--    require('go.format').goimports()
--   end,
--   group = format_sync_grp,
-- })

function M.config()
  require("go").setup()
end

return M
