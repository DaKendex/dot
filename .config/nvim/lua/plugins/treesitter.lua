local M = {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPost", "BufNewFile" },
  build = ":TSUpdate",
}

function M.config()
  require("nvim-treesitter.configs").setup({
    auto_install = true,
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
    highlight = { enable = true },
    indent = { enable = true, disable = { "yaml" } },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<Enter>",
        node_incremental = "<Enter>",
        scope_incremental = false,
        node_decremental = "<Backspace>",
      },
    },
  })
  vim.treesitter.language.register("markdown", "octo")
end

return M
