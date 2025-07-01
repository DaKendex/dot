return {
  { "aklt/plantuml-syntax", ft = { "plantuml" } },
  {
    "weirongxu/plantuml-previewer.vim",
    ft = { "plantuml" },
    dependencies = {
      "tyru/open-browser.vim",
      ft = { "plantuml" },
    },
    config = function()
      vim.keymap.set("n", "<leader>pu", "<cmd>PlantumlOpen<cr>", { desc = "Open PlantUML in browser" })
    end,
  },
}
