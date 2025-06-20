return {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = { "markdown", "Avante", "Obsidian" },
  dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" },
  opt = {
    file_types = { "markdown", "Avante", "Obsidian" },
    completions = {
      blink = {
        enabled = true,
      },
    },
    code = {
      disable_background = true,
      style = 'normal',
      border = 'none',
    }
  }
}
