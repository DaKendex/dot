local M = {
  "folke/which-key.nvim",
  event = "VimEnter",
}

function M.config()
  -- local mappings = {
  -- 	-- q = { "<cmd>confirm q<CR>", "Quit" },
  -- 	h = { "<cmd>nohlsearch<CR>", "NOHL" },
  -- 	[";"] = { "<cmd>tabnew | terminal<CR>", "Term" },
  -- 	v = { "<cmd>vsplit<CR>", "Split" },
  -- 	b = { name = "Buffers" },
  -- 	d = { name = "Debug" },
  -- 	f = { name = "Find" },
  -- 	g = { name = "Git" },
  -- 	l = { name = "LSP" },
  -- 	p = { name = "Plugins" },
  -- 	t = { name = "Test" },
  -- 	a = {
  -- 		name = "Tab",
  -- 		n = { "<cmd>$tabnew<cr>", "New Empty Tab" },
  -- 		N = { "<cmd>tabnew %<cr>", "New Tab" },
  -- 		o = { "<cmd>tabonly<cr>", "Only" },
  -- 		h = { "<cmd>-tabmove<cr>", "Move Left" },
  -- 		l = { "<cmd>+tabmove<cr>", "Move Right" },
  -- 	},
  -- 	T = { name = "Treesitter" },
  -- }

  local which_key = require("which-key")
  which_key.setup({
    plugins = {
      marks = true,
      registers = true,
      -- spelling = {
      --   enabled = true,
      --   suggestions = 20,
      -- },
      presets = {
        operators = false,
        motions = false,
        text_objects = false,
        windows = false,
        nav = false,
        z = false,
        g = true,
      },
    },
    show_help = true,
    show_keys = false,
    disable = {
      buftypes = {},
      filetypes = { "TelescopePrompt" },
    },
  })

  -- local opts = {
  -- 	mode = "n", -- NORMAL mode
  -- 	prefix = "<leader>",
  -- }

  -- which_key.add(mappings, opts)
end

return M
