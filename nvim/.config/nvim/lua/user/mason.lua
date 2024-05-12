local M = {
  "williamboman/mason-lspconfig.nvim",
  dependencies = {
    "williamboman/mason.nvim",
  },
}


function M.config()
  local servers = {
    "lua_ls",
    "html",
    "pyright",
    "bashls",
    "jsonls",
    "terraformls",
    "yamlls",
    "jsonls",
    "gopls",
  }

  require "mason".setup()

  require("mason-lspconfig").setup {
    ensure_installed = servers,
  }
end

return M
