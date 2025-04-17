local M = {
  "MeanderingProgrammer/render-markdown.nvim",
  cmd = { "RenderMarkdown" },
  dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
}

function M.config()
  require("obsidian").get_client().opts.ui.enable = false
  vim.api.nvim_buf_clear_namespace(0, vim.api.nvim_get_namespaces()["ObsidianUI"], 0, -1)
  require("render_markdown").setup({
    -- Options go here
  })
end

return M
