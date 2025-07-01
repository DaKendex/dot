local M = {}

function M.setup()
  local icons = require("user.icons").diagnostics

  local current_vt = vim.diagnostic.config().virtual_text
  if type(current_vt) ~= "table" or current_vt.prefix == "■" then
    vim.api.nvim_set_hl(0, "DiagnosticSignError", { link = "DiagnosticError" })
    vim.api.nvim_set_hl(0, "DiagnosticSignWarn", { link = "DiagnosticWarn" })
    vim.api.nvim_set_hl(0, "DiagnosticSignInfo", { link = "DiagnosticInfo" })
    vim.api.nvim_set_hl(0, "DiagnosticSignHint", { link = "DiagnosticHint" })

    vim.diagnostic.config({
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = icons.Error,
          [vim.diagnostic.severity.WARN] = icons.Warning,
          [vim.diagnostic.severity.INFO] = icons.Information,
          [vim.diagnostic.severity.HINT] = icons.Hint,
        },
        texthl = {
          [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
          [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
          [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
          [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
        },
      },
      virtual_text = {
        virt_text_pos = "eol",
        prefix = "",
        format = function(diagnostic)
          local icon = ({
            [vim.diagnostic.severity.ERROR] = icons.Error,
            [vim.diagnostic.severity.WARN] = icons.Warning,
            [vim.diagnostic.severity.INFO] = icons.Information,
            [vim.diagnostic.severity.HINT] = icons.Hint,
          })[diagnostic.severity] or ""
          return string.format("%s %s", icon, diagnostic.message)
        end,
      },
      float = {
        border = "rounded",
        source = "if_many",
      },
      severity_sort = true,
    })
  end
end

return M
