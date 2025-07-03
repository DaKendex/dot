-- set leader key to space
vim.g.mapleader = " "

local set = vim.keymap.set -- for conciseness

---------------------
-- General  -------------------
set("n", "<leader><leader>x", "<cmd>source %<CR>", { desc = "Reload current file" }) -- reload current file
set("n", "<leader>L", "<cmd>Lazy<CR>", { desc = "Open Lazy" }) -- open Lazy

set("n", "<leader>nh", "<cmd>nohlsearch<CR>", { desc = "NOHL" }) -- clear search highlights
-- use jk to exit insert mode
set("i", "kj", "<ESC>", { desc = "Exit insert mode with jk" })

-- clear search highlights
set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

set("v", "J", ":m '>+1<CR>gv=gv")
set("v", "K", ":m '<-2<CR>gv=gv")

-- delete single character without copying into register
set("n", "x", '"_x')

-- increment/decrement numbers
set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

set("n", "<leader>'", "<C-^>", { desc = "Switch to previous buffer" }) -- switch to previous buffer

-- Center the screen on the cursor
set("n", "<C-u>", "<C-u>zz")
set("n", "<C-d>", "<C-d>zz")
set("n", "{", "{zz")
set("n", "}", "}zz")
set("n", "N", "Nzz")
set("n", "n", "nzz")
set("n", "G", "Gzz")
set("n", "gg", "ggzz")
set("n", "<C-i>", "<C-i>zz")
set("n", "<C-o>", "<C-o>zz")
set("n", "%", "%zz")
set("n", "*", "*zz")
set("n", "#", "#zz")

-- These mappings control the size of splits (height/width)
set("n", "<M-n>", "<c-w>5>")
set("n", "<M-.>", "<c-w>5<")
set("n", "<M-m>", "<C-W>+")
set("n", "<M-,>", "<C-W>-")

-- Copy file path / filepath to the clipboard
set("n", "<leader>fp", function()
  local filePath = vim.fn.expand("%:~") -- Gets the file path relative to the home directory
  vim.fn.setreg("+", filePath) -- Copy the file path to the clipboard register
  print("File path copied to clipboard: " .. filePath) -- Optional: print message to confirm
end, { desc = "[P]Copy file path to clipboard" })

-- open in finder
set("n", "<leader>fo", function()
  local filePath = vim.fn.expand("%:p") -- Gets the full file path
  vim.fn.system({ "open", "-R", filePath }) -- Opens the file in Finder
end, { desc = "[O]pen file in Finder" })
