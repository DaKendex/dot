return {
  "MeanderingProgrammer/render-markdown.nvim",
  cmd = { "RenderMarkdown" },
  dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
  config = function()
    require("render_markdown").setup({
      completions = {
        blink = {
          enabled = true
        }
      },                                                 -- enable completions with blink
      file_types = { "markdown", "Avante", "Obsidian" }, -- file types to render
    })
  end,
}
