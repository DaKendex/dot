local M = {
  "nvim-pack/nvim-spectre",
  event = "BufRead",
  depends = "nvim-lua/plenary.nvim",
}

function M.config()
  require("spectre").setup()
  local set = vim.keymap.set
  set("n", "<leader>S", '<cmd>lua require("spectre").toggle()<CR>', {
    desc = "Toggle Spectre",
  })
  set("n", "<leader>sw", '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
    desc = "Search current word",
  })
  set("v", "<leader>sw", '<esc><cmd>lua require("spectre").open_visual()<CR>', {
    desc = "Search current word",
  })
  set("n", "<leader>sp", '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
    desc = "Search on current file",
  })
end

return M
