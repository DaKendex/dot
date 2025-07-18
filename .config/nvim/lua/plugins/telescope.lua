local M = {
  "nvim-telescope/telescope.nvim",
  -- tag = '0.1.6',
  dependencies = {
    "nvim-lua/plenary.nvim",
    "echasnovski/mini.icons",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make", lazy = true },
    "nvim-telescope/telescope-ui-select.nvim",
  },
  cmd = "Telescope",
}

function M.config()
  local icons = require("user.icons")
  local actions = require("telescope.actions")

  local builtin = require("telescope.builtin")

  local map = function(keys, func, desc, mode)
    mode = mode or { "n" }
    vim.keymap.set(mode, keys, func, { desc = "Telescope: " .. desc })
  end

  map("<C-p>", builtin.git_files, "Find files") -- find files in the current directory
  map("<leader>ff", function()
    builtin.find_files({})
  end, "Find files")
  map("<leader>fF", function() -- grep in the current directory
    builtin.find_files({ cwd = vim.fn.expand("%:p:h") })
  end, "Find files in Root Dir")
  map("<leader>ft", function() -- grep in the root directory
    builtin.live_grep({})
    vim.cmd("normal! zz")
  end, "Live Grep")
  map("<leader>fT", function()
    builtin.live_grep({ cwd = vim.fn.expand("%:p:h") })
    vim.cmd("normal! zz")
  end, "Live Grep in Root Dir")
  map("<leader>ps", function()
    local word = vim.fn.expand("<cword>")
    builtin.grep_string({ search = word })
    vim.cmd("normal! zz")
  end, "Grep Word")
  map("<leader>pS", function()
    builtin.grep_string({ search = vim.fn.input("Grep for > ") })
    vim.cmd("normal! zz")
  end, "Grep")
  map("<leader>fh", function()
    builtin.help_tags({})
  end, "Help")
  map("<leader>fk", function()
    builtin.keymaps({})
  end, "Keymaps")
  -- vim.keymap.set("n", "<leader>fl", function()
  --   builtin.resume({})
  -- end, { desc = "Last Search" })
  -- vim.keymap.set("n", "<leader>fr", function()
  --   builtin.oldfiles({})
  -- end, { desc = "Recent File" })

  require("telescope").setup({

    defaults = {
      file_ignore_patterns = { ".git/", ".terraform/" },
      prompt_prefix = icons.ui.Telescope .. " ",
      selection_caret = icons.ui.Forward .. " ",
      layout_config = {
        height = 0.8,
        width = 0.8,
        preview_cutoff = 0,
        horizontal = { preview_width = 0.60 },
        vertical = { width = 0.999, height = 0.9999, preview_cutoff = 0 },
        prompt_position = "bottom",
      },
      entry_prefix = "   ",
      initial_mode = "insert",
      selection_strategy = "reset",
      path_display = { "smart" },
      color_devicons = true,
      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
        "--hidden",
        "--glob=!.git/",
      },

      mappings = {
        i = {
          ["<C-n>"] = actions.cycle_history_next,
          ["<C-p>"] = actions.cycle_history_prev,

          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
        },
        n = {
          ["<esc>"] = actions.close,
          ["j"] = actions.move_selection_next,
          ["k"] = actions.move_selection_previous,
          ["q"] = actions.close,
        },
      },
    },
    pickers = {
      live_grep = {
        -- theme = "ivy",
      },

      grep_string = {
        -- theme = "ivy",
      },

      find_files = {
        -- theme = "dropdown",
        previewer = true,
        hidden = true,
      },

      buffers = {
        -- theme = "dropdown",
        -- previewer = true,
        initial_mode = "normal",
        mappings = {
          i = {
            ["<C-d>"] = actions.delete_buffer,
          },
          n = {
            ["dd"] = actions.delete_buffer,
          },
        },
      },

      planets = {
        show_pluto = true,
        show_moon = true,
      },

      colorscheme = {
        enable_preview = true,
      },

      lsp_references = {
        -- theme = "dropdown",
        initial_mode = "normal",
      },

      lsp_definitions = {
        -- theme = "dropdown",
        initial_mode = "normal",
      },

      lsp_declarations = {
        -- theme = "dropdown",
        initial_mode = "normal",
      },

      lsp_implementations = {
        -- theme = "dropdown",
        initial_mode = "normal",
      },
    },
    extensions = {
      fzf = {
        fuzzy = true, -- false will only do exact matching
        override_generic_sorter = true, -- override the generic sorter
        override_file_sorter = true, -- override the file sorter
        case_mode = "smart_case", -- or "ignore_case" or "respect_case"
      },
    },
  })
  require("telescope").load_extension("fzf")
  require("telescope").load_extension("harpoon")
  require("telescope").load_extension("ui-select")
  -- require("telescope").load_extension("live_grep_args")
  -- require("telescope").load_extension("smart_goto")
  -- require("telescope").load_extension("smart_open")
end

return M
