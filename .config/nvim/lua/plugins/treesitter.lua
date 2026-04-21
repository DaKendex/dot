local M = {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPost", "BufNewFile" },
  build = ":TSUpdate",
}

function M.config()
  local treesitter = require("nvim-treesitter")

  treesitter.setup({
    install_dir = vim.fn.stdpath("data") .. "/site",
  })

  treesitter.install({
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
  })
  vim.treesitter.language.register("markdown", "octo")
end

return M
