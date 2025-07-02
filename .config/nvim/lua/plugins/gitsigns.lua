local M = {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPost", "BufNewFile" },
}
M.config = function()
  local map = function(keys, func, desc, mode)
    mode = mode or { "n", "v" }
    vim.keymap.set(
      mode,
      keys,
      func,
      { buffer = vim.api.nvim_get_current_buf(), desc = "[G]it: " .. desc }
    )
  end
  map(
    "gj",
    "<cmd>lua require 'gitsigns'.next_hunk({navigation_message = false})<cr>zz",
    "Next Hunk"
  )
  map(
    "gk",
    "<cmd>lua require 'gitsigns'.prev_hunk({navigation_message = false})<cr>zz",
    "Prev Hunk"
  )
  map("ghp", "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "[H]unk [P]review")
  map("ghr", "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "[H]unk [R]eset")
  map("ghs", ":Gitsigns stage_hunk<CR>", "[H]unk [S]tage")
  map("<leader>gl", ":Gitsigns blame_line<CR>", "Blame [L]ine")
  map("<leader>gR", "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "[R]eset Buffer")
  map("ghu", "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", "[H]unk [U]ndo Stage")
  map("<leader>gd", "<cmd>Gitsigns diffthis HEAD<cr>", "[G]it [D]iff This")

  require("gitsigns").setup({
    signs = {
      add = { text = "+" },
      change = { text = "~" },
      delete = { text = "_" },
      topdelete = { text = "‾" },
      changedelete = { text = "~" },
    },
    watch_gitdir = {
      interval = 1000,
      follow_files = true,
    },
    attach_to_untracked = true,
    current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
    update_debounce = 200,
    max_file_length = 40000,
    preview_config = {
      border = "rounded",
      style = "minimal",
      relative = "cursor",
      row = 0,
      col = 1,
    },
  })
end

return M
