local M = {
	"utilyre/barbecue.nvim",
	name = "barbecue",
	event = "BufEnter",
	version = "*",
	dependencies = {
		"SmiteshP/nvim-navic",
		"nvim-tree/nvim-web-devicons",
	},
}

function M.config()
	require("barbecue").setup()
end

return M
