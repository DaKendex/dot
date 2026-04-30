local M = {
  "linrongbin16/gitlinker.nvim",
  dependencies = { { "nvim-lua/plenary.nvim" } },
  event = { "BufReadPre", "BufNewFile" },
}
-- GitLink: generate git link and copy to clipboard.
-- GitLink!: generate git link and open in browser.
-- GitLink blame: generate the /blame url and copy to clipboard.
-- GitLink! blame: generate the /blame url and open in browser.

function M.config()
  local map = function(keys, func, desc, mode)
    mode = mode or { "n", "v" }
    vim.keymap.set(mode, keys, func, { desc = "[G]it: " .. desc })
  end
  map("<leader>gy", "<cmd>GitLink<cr>", "Git link")
  map("<leader>gY", "<cmd>GitLink!<cr>", "Open link")
  map("<leader>gb", "<cmd>GitLink blame<cr>", "Git link blame")
  map("<leader>gL", "<cmd>GitLink! blame<cr>", "Open Git blame link")

  local function github_url(lk, path_type, rev)
    local repo = lk.repo:gsub("%.git$", "")
    local loc = lk.file .. string.format("?plain=1#L%d", lk.lstart)
    if lk.lend > lk.lstart then
      loc = loc .. string.format("-L%d", lk.lend)
    end
    return string.format("https://%s/%s/%s/%s/%s/%s", lk.host, lk.org, repo, path_type, rev, loc)
  end

  local function branch_on_remote(branch, dir)
    vim.fn.system(string.format(
      "git -C %s rev-parse --verify refs/remotes/origin/%s",
      vim.fn.shellescape(dir), vim.fn.shellescape(branch)
    ))
    return vim.v.shell_error == 0
  end

  require("gitlinker").setup({
    console_log = true,
    router = {
      browse = {
        ["^github%.com"] = function(lk)
          local branch = lk.current_branch
          local dir = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":p:h")
          if branch and branch_on_remote(branch, dir) then
            return github_url(lk, "blob", branch)
          end
          vim.notify(
            string.format("gitlinker: '%s' not on remote, using blame link", branch or "detached"),
            vim.log.levels.WARN
          )
          return github_url(lk, "blame", lk.rev)
        end,
      },
    },
  })
end

return M
