local M = {}

function M.sort_blocks(opts)
  local ft = vim.bo.filetype
  local key = opts.key or "name"
  local start_line = opts.range and (opts.range[1] - 1) or 0
  local end_line = opts.range and opts.range[2] or -1

  local patterns = {
    toml = "^%[%[",
    terraform = "^resource%s+",
    yaml = "^%-",
    json = "^%s*%{",
    lua = "^%s*%{",
  }

  local block_start = opts.block_start or patterns[ft] or "^%[%["

  local lines = vim.api.nvim_buf_get_lines(0, start_line, end_line, false)
  local blocks, current = {}, {}

  for _, line in ipairs(lines) do
    if line:match(block_start) and #current > 0 then
      table.insert(blocks, table.concat(current, "\n"))
      current = {}
    end
    table.insert(current, line)
  end
  if #current > 0 then
    table.insert(blocks, table.concat(current, "\n"))
  end

  local function extract_value(block)
    return block:match(key .. '%s*=%s*"(.-)"')
        or block:match(key .. '%s*:%s*"(.-)"')
        or block:match(key .. '%s*=%s*([^"\n]+)')
        or block:match(key .. '%s*:%s*([^"\n]+)')
        or ""
  end

  table.sort(blocks, function(a, b)
    return extract_value(a) < extract_value(b)
  end)

  vim.api.nvim_buf_set_lines(0, start_line, end_line, false, vim.split(table.concat(blocks, "\n\n"), "\n"))
end

function M.setup()
  vim.api.nvim_create_user_command("SortBlocks", function(opts)
    local range = opts.range ~= 0 and { opts.line1, opts.line2 } or nil
    M.sort_blocks({ key = opts.args ~= "" and opts.args or nil, range = range })
  end, {
    nargs = "?",
    range = true,
    desc = "Sort blocks by a given field name (auto-detect structure)",
  })

  vim.keymap.set({ "n", "v" }, "<leader>sb", function()
    local mode = vim.fn.mode()
    local range = nil
    if mode == "v" or mode == "V" then
      local start = vim.fn.line("'<")
      local finish = vim.fn.line("'>")
      range = { start, finish }
    end
    M.sort_blocks({ key = "name", range = range })
  end, { desc = "[S]ort [B]locks by name" })
end

return M
