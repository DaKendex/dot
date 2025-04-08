return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        lua = { "stylua" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        terraform = { "terraform_fmt" },
        html = { "prettier" },
        css = { "prettier" },
        scss = { "prettier" },
        python = { "black" },
        go = { "goimports_reviser", "golines", "gofumpt" },
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
