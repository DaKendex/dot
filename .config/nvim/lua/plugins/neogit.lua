return {
  "NeogitOrg/neogit",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    "nvim-lua/plenary.nvim", -- required
    "sindrets/diffview.nvim", -- optional - Diff integration
    "nvim-telescope/telescope.nvim", -- optional
  },
  config = function()
    local map = function(keys, func, desc, mode)
      mode = mode or { "n" }
      vim.keymap.set(mode, keys, func, {
        buffer = vim.api.nvim_get_current_buf(),
        desc = "[G]it: " .. desc,
        silent = true,
        noremap = true,
      })
    end
    map("<leader>gs", "<cmd>Neogit<CR>", "Neogit [S]tatus")
    map("<leader>gc", "<cmd>Neogit commit<CR>", "Neogit [C]ommit")
    map("<leader>gp", "<cmd>Neogit pull<CR>", "Neogit [P]ull")
    map("<leader>gP", "<cmd>Neogit push<CR>", "Neogit [P]ush")
    map("<leader>gb", "<cmd>Telescope git_branches<CR>", "Telescope Git [B]ranches")
    -- map("<leader>gB", "<cmd>G blame<CR>", "Git [B]lame")
    require("neogit").setup({})
  end,
}
