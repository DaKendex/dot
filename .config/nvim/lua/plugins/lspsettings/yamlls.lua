return {
  settings = {
    yaml = {
      schemas = require("plugins.schemastore").yaml.schemas(),
      validate = true,
    },
  },
  setup = {
    commands = {
      Format = {
        function()
          vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line "$", 0 })
        end,
      },
    },
  },
}
