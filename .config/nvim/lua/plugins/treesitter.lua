local M = {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPost", "BufNewFile" },
  build = ":TSUpdate",
}

function M.config()
  require("nvim-treesitter").setup({
    ensure_installed = {
      "bash",
      "go",
      "graphql",
      "hcl",
      "lua",
      "markdown",
      "markdown_inline",
      "python",
      "terraform",
      "tmux",
      "vim",
      "vimdoc",
      "yaml",
    },
  })
  vim.treesitter.language.register("markdown", "octo")
end

return M
