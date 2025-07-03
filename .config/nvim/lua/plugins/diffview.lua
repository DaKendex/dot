return {
  "sindrets/diffview.nvim",
  cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
  keys = {
    { "<leader>dd", "<cmd>DiffviewOpen<cr>", desc = "[D]iffview Open" },
    { "<leader>dh", "<cmd>DiffviewFileHistory<cr>", desc = "[D]iffview File [H]istory" },
    { "<leader>dc", "<cmd>DiffviewClose<cr>", desc = "[D]iffview [C]lose" },
  },
}
