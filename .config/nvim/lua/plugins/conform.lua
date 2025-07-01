return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("conform").setup({
      format_on_save = function(bufnr)
        -- Disable with a global or buffer-local variable
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end
        return { timeout_ms = 500, lsp_format = "fallback" }
      end,
      formatters_by_ft = {
        bash = { "shfmt" },
        shell = { "shfmt" },
        lua = { "stylua" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        json = { "prettier" },
        groovy = { "npm-groovy-lint" },
        yaml = { "prettier" },
        terraform = { "terraform_fmt" },
        html = { "prettier" },
        css = { "prettier" },
        scss = { "prettier" },
        python = { "black" },
        go = { "goimports-reviser", "golines", "gofumpt" },
        markdown = { "prettier" },
      },
      formatters = {
        -- optional: override args
        -- prettier = {
        --   prepend_args = { "--no-semi", "--single-quote" },
        -- },
      },
      notify_on_error = true,
      log_level = vim.log.levels.WARN,
    })
  end,
}
