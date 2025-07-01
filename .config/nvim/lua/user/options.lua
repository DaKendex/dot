local opt = vim.opt -- for conciseness
vim.cmd("let g:netrw_liststyle = 3")
vim.lsp.set_log_level("ERROR") -- set LSP log level to debug
opt.cmdheight = 0 -- height of command line

opt.spelllang = "en_us" -- set spell language to english
opt.spell = false -- enable spell checking

-- line numbers
opt.relativenumber = true -- show relative line numbers
opt.number = true -- shows absolute line number on cursor line (when relative number is on)

-- tabs & indentation
opt.tabstop = 2 -- 2 spaces for tabs (prettier default)
opt.shiftwidth = 2 -- 2 spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one
opt.smartindent = true

-- line wrapping
opt.wrap = true -- disable line wrapping

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

-- cursor line
opt.cursorline = false -- highlight the current cursor line

-- appearance

-- turn on termguicolors for nightfly colorscheme to work
-- (have to use iterm2 or any other true color terminal)
opt.termguicolors = true
opt.background = "dark" -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes" -- show sign column so that text doesn't shift

-- font
-- opt.guifont = "Hack Nerd Font" -- set font to Hack Nerd Font with size 12
opt.guifont = "JetBrainsMono Nerd Font" -- set font to JetBrainsMono Nerd Font with size 12

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- turn off swapfile
opt.swapfile = false

-- obsidian conceal level
opt.conceallevel = 1

-- Consider - as part of keyword
opt.iskeyword:append("-")

-- opt.inccomand = "split"
-- vim.g.disable_autoformat = true

-- NOTE: workaround for current bug
-- https://github.com/pwntester/octo.nvim/issues/466
vim.g.octo_viewer = "dakendex"
