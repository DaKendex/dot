local M = {
  "linrongbin16/gitlinker.nvim",
  dependencies = { { "nvim-lua/plenary.nvim" } },
  event = { "BufReadPre", "BufNewFile" },
}
-- GitLink: generate git link and copy to clipboard.
-- GitLink!: generate git link and open in browser.
-- GitLink blame: generate the /blame url and copy to clipboard.
-- GitLink! blame: generate the /blame url and open in browser.

function M.config()
  local map = function(keys, func, desc, mode)
    mode = mode or { "n", "v" }
    vim.keymap.set(
      mode,
      keys,
      func,
      { buffer = vim.api.nvim_get_current_buf(), desc = "[G]it: " .. desc }
    )
  end
  map("<leader>gy", "<cmd>GitLink<cr>", "Git link")
  map("<leader>gY", "<cmd>GitLink!<cr>", "Open link")
  map("<leader>gb", "<cmd>GitLink blame<cr>", "Git link blame")
  map("<leader>gL", "<cmd>GitLink! blame<cr>", "Open Git blame link")

  require("gitlinker").setup({
    console_log = true,
  })
end

return M
