local function customFormatter()
  local util = require('formatter.util')
  local M = {}

  function M.sqlfluff()
    local sqlfluff_cfg_path = vim.fn.getcwd() .. '/.sqlfluff.cfg'
    if vim.fn.filereadable(sqlfluff_cfg_path) ~= 1 then
      sqlfluff_cfg_path = vim.fn.expand('~') .. '/.config/sqlfluff/setup.cfg'
    end
    return {
      exe = 'sqlfluff',
      args = {
        'format',
        '--config',
        sqlfluff_cfg_path,
        '-',
      },
      stdin = true,
    }
  end

  function M.npx_prettier()
    return {
      exe = 'npx prettier',
      args = {
        '--stdin-filepath',
        util.escape_path(util.get_current_buffer_file_path()),
      },
      stdin = true,
    }
  end

  function M.npx_eslint()
    return {
      exe = 'npx eslint',
      args = {
        '--fix',
        '--ext',
        '.' .. vim.fn.expand('%:e'),
      },
      stdin = false,
    }
  end

  -- プロジェクト直下にprettier設定ファイルがあればPrettierを使用し、ない場合はESLintをフォーマッタとして使用する
  function M.prettier_or_eslint()
    local local_prettier = vim.fn.fnamemodify('./node_modules/.bin/prettier', ':p')
    local local_prettier_stat = vim.loop.fs_stat(local_prettier)

    local local_eslint = vim.fn.fnamemodify('./node_modules/.bin/eslint', ':p')
    local local_eslint_stat = vim.loop.fs_stat(local_eslint)

    if local_prettier_stat then
      return M.npx_prettier()
    elseif local_eslint_stat then
      return M.npx_eslint()
    else
      return {}
    end
  end

  return M
end

return {
  {
    'mhartington/formatter.nvim',
    event = { 'BufAdd', 'BufReadPost' },
    keys = {
      { '<leader>fm', '<Cmd>FormatWrite<Cr>', desc = '[F]or[M]at', { noremap = true, silent = true } },
    },
    config = function()
      local util = require('formatter.util')

      local stylua = require('formatter.filetypes.lua').stylua
      local shfmt = require('formatter.filetypes.sh').shfmt
      local taplo = require('formatter.filetypes.toml').taplo
      local C = customFormatter()

      require('formatter').setup({
        filetype = {
          css = { C.npx_prettier },
          html = { C.prettier_or_eslint },
          javascript = { C.prettier_or_eslint },
          javascriptreact = { C.prettier_or_eslint },
          json = { C.npx_prettier },
          lua = { stylua },
          markdown = { C.npx_prettier },
          prisma = {},
          sh = { shfmt },
          svelte = { C.prettier_or_eslint },
          sql = { C.sqlfluff },
          toml = { taplo },
          typescript = { C.prettier_or_eslint },
          typescriptreact = { C.prettier_or_eslint },
          vue = { C.prettier_or_eslint },
          yaml = { C.npx_prettier },
          ['*'] = {
            require('formatter.filetypes.any').remove_trailing_whitespace,
          },
        },
      })
    end,
  },
}
