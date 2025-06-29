local M = {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPost", "BufNewFile" },
  build = ":TSUpdate",
}

-- local parser_config = require'nvim-treesitter.parsers'.get_parser_configs()
-- parser_config.gotmpl = {
--   install_info = {
--     url = "https://github.com/ngalaiko/tree-sitter-go-template",
--     files = {"src/parser.c"}
--   },
--   filetype = "gotmpl",
--   used_by = {"gohtmltmpl", "gotexttmpl", "gotmpl", "yaml"}
-- }

function M.config()
  require("nvim-treesitter.configs").setup({
    auto_install = true,
    sync_install = false,
    ignore_install = {},
    modules = {},
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
    indent = { enable = true },
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
