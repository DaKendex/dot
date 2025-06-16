return {
  "stevearc/oil.nvim",
  dependencies =
  { 'echasnovski/mini.icons', opts = {}, version = false },

  config = function()
    require("oil").setup({
      columns = { "icon" },
      float = {
        -- 	max_height = 40,
        -- 	max_width = 120,
        preview_split = "right",
      },
      keymaps = {
        ["<S-h>"] = "actions.select_split",
      },
      view_options = {
        show_hidden = true,
      },
    })
    -- vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
    vim.keymap.set("n", "-", "<CMD>lua require('oil').open_float()<CR>", { desc = "Open parent directory" })
    -- vim.keymap.set("n", "-", function()
    --   vim.cmd("split | Oil")
    -- end, { desc = "Open parent directory" })
  end,
}
