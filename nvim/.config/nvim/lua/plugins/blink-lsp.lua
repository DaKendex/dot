local M = {
	"saghen/blink.cmp",
	dependencies = { "saghen/blink.cmp" },
  enabled = false,
}
-- example using `opts` for defining servers
M.opts = {
	servers = {
    lua_ls = {},
		cssls = {},
    html = {},
    eslint = {},
    pyright = {},
    bashls = {},
    jsonls = {},
    yamlls = {},
    terraformls = {},
    gopls = {},
    omnisharp = {},
	}
}
function M.config()
	local lspconfig = require("lspconfig")
	for server, config in pairs(M.opts.servers) do
		config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
		lspconfig[server].setup(config)
	end
end

return M
