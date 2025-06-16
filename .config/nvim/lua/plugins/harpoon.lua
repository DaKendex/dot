local M = {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  event = "BufReadPost",
  dependencies = {
    { "nvim-lua/plenary.nvim" },
  },
}

function M.config()
  local keymap = vim.keymap.set
  local opts = { noremap = true, silent = true }

  local harpoon = require("harpoon")
  harpoon:setup({})

  -- basic telescope configuration
  local conf = require("telescope.config").values
  local function toggle_telescope(harpoon_files)
    local file_paths = {}
    for _, item in ipairs(harpoon_files.items) do
      table.insert(file_paths, item.value)
    end

    require("telescope.pickers")
        .new({}, {
          prompt_title = "Harpoon",
          finder = require("telescope.finders").new_table({
            results = file_paths,
          }),
          previewer = conf.file_previewer({}),
          sorter = conf.generic_sorter({}),
        })
        :find()
  end

  -- With Telescope
  keymap("n", "<c-e>", function()
    toggle_telescope(harpoon:list())
  end, { desc = "Open harpoon window" })

  keymap("n", "<s-m>", function()
    harpoon:list():add()
  end, opts)
  keymap("n", "<TAB>", function()
    harpoon.ui:toggle_quick_menu(harpoon:list())
  end, opts)
end

function M.mark_file()
  require("harpoon.mark").add_file()
  vim.notify("󱡅  marked file")
end

return M
