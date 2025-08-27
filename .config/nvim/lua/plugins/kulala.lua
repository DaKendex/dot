return {
  "mistweaverco/kulala.nvim",
  keys = {
    { "<leader>rs", desc = "Send Request" },
    { "<leader>ra", desc = "Send All Requests" },
    { "<leader>rb", desc = "Open scratchpad" },
  },
  ft = { "http", "rest" },
  opts = {
    global_keymaps = true,
    global_keymaps_prefix = "<leader>r",
    global_keymaps_prefix = "",
  },
}
