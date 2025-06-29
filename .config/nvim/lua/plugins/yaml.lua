local M = {
  "cuducos/yaml.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-telescope/telescope.nvim" },
  ft = { "yaml", "yml" },
}

function M.config()
  require("yaml_nvim").setup({ ft = { "yaml", "yml" } })
end

return M
