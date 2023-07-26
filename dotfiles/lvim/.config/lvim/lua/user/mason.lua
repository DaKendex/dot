require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    "awk_ls",
    "bashls",
    "cssls",
    "dockerls",
    "gopls",
    "gradle_ls",
    "grammarly",
    "graphql",
    "html",
    "jsonls",
    "tsserver",
    "sumneko_lua",
    "marksman",
    "pyright",
    "pylsp",
    "sqlls",
    "tailwindcss",
    "terraformls",
    "tflint",
    "vuels",
    "yamlls",
    "hcl"
  }
})
