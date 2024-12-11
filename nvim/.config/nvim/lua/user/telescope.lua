local M = {
	"nvim-telescope/telescope.nvim",
	-- tag = '0.1.6',
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make", lazy = true },
	},
	cmd = "Telescope",
}

function M.config()
	local wk = require("which-key")
	wk.register({
		["<leader>bb"] = { "<cmd>Telescope buffers previewer=false<cr>", "Find" },
		["<leader>fb"] = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
		["<leader>fc"] = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
		-- ["<leader>ff"] = { "<cmd>Telescope find_files<cr>", "Find files" },
		-- ["<leader>fp"] = { "<cmd>lua require('telescope').extensions.projects.projects()<cr>", "Projects" },
		-- ["<leader>ft"] = { "<cmd>Telescope live_grep<cr>", "Find Text" },
		["<leader>fh"] = { "<cmd>Telescope help_tags<cr>", "Help" },
		["<leader>fl"] = { "<cmd>Telescope resume<cr>", "Last Search" },
		["<leader>fr"] = { "<cmd>Telescope oldfiles<cr>", "Recent File" },
	})

	local icons = require("user.icons")
	local actions = require("telescope.actions")

	local builtin = require("telescope.builtin")

	vim.keymap.set("n", "<C-p>", builtin.git_files, { desc = "Find files" })
  -- find files in the current directory
	vim.keymap.set("n", "<leader>ff", function()
		builtin.find_files({ cwd = vim.fn.expand("%:p:h") })
	end)
  -- find files in the root directory
	vim.keymap.set("n", "<leader>fF", function()
		builtin.find_files({})
	end)
  -- grep in the current directory
	vim.keymap.set("n", "<leader>ft", function()
		builtin.live_grep({ cwd = vim.fn.expand("%:p:h") })
	end)
  -- grep in the root directory
	vim.keymap.set("n", "<leader>fT", function()
		builtin.live_grep({})
	end)

	vim.keymap.set("n", "<leader>pws", function()
		local word = vim.fn.expand("<cword>")
		builtin.grep_string({ search = word })
	end)
	vim.keymap.set("n", "<leader>ps", function()
		builtin.grep_string({ search = vim.fn.input("Grep for > ") })
	end)

	require("telescope").setup({

		defaults = {
			file_ignore_patterns = { ".git/", ".terraform/" },
			prompt_prefix = icons.ui.Telescope .. " ",
			selection_caret = icons.ui.Forward .. " ",
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
				theme = "dropdown",
			},

			grep_string = {
				theme = "dropdown",
			},

			find_files = {
				theme = "dropdown",
				previewer = true,
				hidden = true,
			},

			buffers = {
				theme = "dropdown",
				previewer = true,
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
				theme = "dropdown",
				initial_mode = "normal",
			},

			lsp_definitions = {
				theme = "dropdown",
				initial_mode = "normal",
			},

			lsp_declarations = {
				theme = "dropdown",
				initial_mode = "normal",
			},

			lsp_implementations = {
				theme = "dropdown",
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
	-- require("telescope").load_extension("live_grep_args")
	-- require("telescope").load_extension("smart_goto")
	-- require("telescope").load_extension("smart_open")
end

return M
