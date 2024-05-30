local M = {
	"David-Kunz/gen.nvim",
  event = "BufReadPre",
}

function M.config()
	require("gen").setup({
		model = "codellama",
		display_mode = "float",
	})
	require("gen").prompts["Elaborate_Text"] = {
		prompt = "Elaborate the following text. If there are code snippets, leave them in place, but you can add comments:\n$text",
		replace = true,
	}
	require("gen").prompts["Fix_Code"] = {
		prompt = "Fix the following code. Only output the result in format ```$filetype\n...\n```:\n```$filetype\n$text\n```",
		replace = true,
		extract = "```$filetype\n(.-)```",
	}
end

vim.keymap.set({ "n", "v" }, "<leader>ai", ":Gen<CR>")
return M
