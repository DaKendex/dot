vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  callback = function()
    vim.cmd("set formatoptions-=cro")
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = {
    "netrw",
    "Jaq",
    "qf",
    "git",
    "help",
    "man",
    "lspinfo",
    "oil",
    "spectre_panel",
    "lir",
    "DressingSelect",
    "tsplayground",
    "Avante",
    "AvanteInput",
  },
  callback = function()
    vim.cmd([[
	     nnoremap <silent> <buffer> q :close<CR>
	     set nobuflisted
	   ]])
  end,
})

-- vim.api.nvim_create_autocmd('FileType', {
--     pattern = 'Avante',
--     callback = function()
--         vim.keymap.set({'n', 'o'}, '<ESC>', '<Nop>', { buffer = true })
--     end
-- })

-- Workaround to use macros with cmdheight 0
vim.api.nvim_create_autocmd("RecordingEnter", {
  callback = function(ctx)
    vim.opt.cmdheight = 1
    local msg = string.format("Key:  %s\nFile: %s", vim.fn.reg_recording(), ctx.file)
    vim.notify(msg, vim.log.levels.INFO, {
      title = "Macro Recording",
    })
  end,
})

vim.api.nvim_create_autocmd("RecordingLeave", {
  callback = function()
    vim.opt.cmdheight = 0
  end,
})

-- vim.api.nvim_create_autocmd({ "CmdWinEnter" }, {
-- 	callback = function()
-- 		vim.cmd("quit")
-- 	end,
-- })

vim.api.nvim_create_autocmd({ "VimResized" }, {
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  pattern = { "*" },
  callback = function()
    vim.cmd("checktime")
  end,
})

vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  callback = function()
    vim.hl.on_yank({ higroup = "Visual", timeout = 40 })
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "gitcommit", "markdown", "NeogitCommitMessage" },
  callback = function()
    vim.opt_local.textwidth = 72
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

vim.api.nvim_create_autocmd({ "CursorHold" }, {
  callback = function()
    local status_ok, luasnip = pcall(require, "luasnip")
    if not status_ok then
      return
    end
    if luasnip.expand_or_jumpable() then
      -- ask maintainer for option to make this silent
      -- luasnip.unlink_current()
      vim.cmd([[silent! lua require("luasnip").unlink_current()]])
    end
  end,
})

-- vim.cmd([[
--   nnoremap q q
-- ]])
vim.cmd("ShowkeysToggle")

vim.api.nvim_create_autocmd("BufWinEnter", {
  callback = function()
    require("user.diagnostics").setup()
  end,
})

vim.api.nvim_create_user_command("YamllsConfig", function()
  local clients = vim.lsp.get_clients({ name = "yamlls" })
  local client = clients[1]
  if client then
    print(vim.inspect(client.config.settings))
  else
    print("yamlls not active in this buffer")
  end
end, {})

vim.api.nvim_create_autocmd("BufWritePost", {
  desc = "Auto reload tmux config",
  pattern = { "tmux/.config/tmux/*.conf" },
  command = "!tmux source ~/.config/tmux/tmux.conf",
})

vim.api.nvim_create_autocmd("BufWritePost", {
  desc = "Auto reload aerospace config",
  pattern = { "aerospace.toml" },
  command = "!aerospace reload-config",
})
--
-- function SortBlocks(opts)
--   local ft = vim.bo.filetype
--   local key = opts.key or "name"
--   local start_line = opts.range and (opts.range[1] - 1) or 0
--   local end_line = opts.range and opts.range[2] or -1
--
--   -- Default block start patterns by filetype
--   local patterns = {
--     toml = "^%[%[",           -- [[session]]
--     terraform = "^resource%s+", -- resource ...
--     yaml = "^%-",             -- - name: ...
--     json = "^%s*%{",          -- { ... }
--     lua = "^%s*%{",           -- { name = ..., ... }
--   }
--
--   local block_start = opts.block_start or patterns[ft] or "^%[%["
--
--   local lines = vim.api.nvim_buf_get_lines(0, start_line, end_line, false)
--   local blocks, current = {}, {}
--
--   for _, line in ipairs(lines) do
--     if line:match(block_start) and #current > 0 then
--       table.insert(blocks, table.concat(current, "\n"))
--       current = {}
--     end
--     table.insert(current, line)
--   end
--   if #current > 0 then
--     table.insert(blocks, table.concat(current, "\n"))
--   end
--
--   local function extract_value(block)
--     return block:match(key .. '%s*=%s*"(.-)"') -- key = "value"
--         or block:match(key .. '%s*:%s*"(.-)"') -- key: "value"
--         or block:match(key .. '%s*=%s*([^"\n]+)') -- key = value
--         or block:match(key .. '%s*:%s*([^"\n]+)') -- key: value
--         or ""
--   end
--
--   table.sort(blocks, function(a, b)
--     return extract_value(a) < extract_value(b)
--   end)
--
--   vim.api.nvim_buf_set_lines(0, start_line, end_line, false, vim.split(table.concat(blocks, "\n"), "\n"))
-- end
--
-- vim.api.nvim_create_user_command("SortBlocks", function(opts)
--   local range = opts.range ~= 0 and { opts.line1, opts.line2 } or nil
--   SortBlocks({
--     key = opts.args ~= "" and opts.args or nil,
--     range = range,
--   })
-- end, {
--   nargs = "?",
--   range = true,
--   desc = "Sort blocks by field (auto-detect structure)",
-- })
