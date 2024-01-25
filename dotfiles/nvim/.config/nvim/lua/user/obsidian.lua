local M = {
  "epwalsh/obsidian.nvim",
  version = "*",
  lazy = true,
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
}

function M.config()
  require("obsidian").setup {
  opts = {
    workspaces = {
    {
        name = "datavant",
        path = "~/repo/dv/datavant",
      },
    },
  },
}
end

return M
