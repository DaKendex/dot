local M = {
	"iamcco/markdown-preview.nvim",
	cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	ft = { "markdown" },
	build = function()
		vim.fn["mkdp#util#install"]()
	end,
}

function M.config()
end

vim.keymap.set("n", "<leader>md", "<cmd>MarkdownPreviewToggle<cr>",  { desc = "Markdown Preview Toggle", noremap = true, silent = true })
return M
