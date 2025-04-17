local M = {
  "catppuccin/nvim",
  as = "catppuccin",
  lazy = false,
  priority = 1000,
}

function M.config()
  require("catppuccin").setup({
    flavour = "mocha",
    transparent_background = true,
    styles = {
      comments = { "italic" },
      functions = { "italic" },
      operators = { "italic" },
      conditionals = { "italic" },
      loops = { "italic" },
      booleans = { "bold", "italic" },
    },
    no_underline = true,
    integrations = {
      harpoon = true,
      cmp = true,
      gitsigns = true,
      telescope = true,
      which_key = true,
      neogit = true,
      mason = true,
      fidget = true,
      native_lsp = {
        enabled = true,
        virtual_text = {
          errors = { "italic" },
          hints = { "italic" },
          warnings = { "italic" },
          information = { "italic" },
        },
      },
    },
  })
  vim.cmd.colorscheme("catppuccin")
end

return M
