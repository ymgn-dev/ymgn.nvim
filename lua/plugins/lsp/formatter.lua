return {
  {
    'mhartington/formatter.nvim',
    event = { 'BufAdd', 'BufReadPost' },
    keys = {
      { '<leader>fm', '<Cmd>FormatWrite<Cr>', desc = '[F]or[M]at', { noremap = true, silent = true } },
    },
    config = function()
      local stylua = require('formatter.filetypes.lua').stylua
      local shfmt = require('formatter.filetypes.sh').shfmt
      local taplo = require('formatter.filetypes.toml').taplo
      local prettier = require('formatter.defaults').prettier

      local function format_sql()
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

      -- プロジェクト直下にprettier設定ファイルがあればPrettierを使用し、ない場合はESLintをフォーマッタとして使用する
      local function format_prettier_or_eslint()
        local local_prettier = vim.fn.fnamemodify('./node_modules/.bin/prettier', ':p')
        local local_prettier_stat = vim.loop.fs_stat(local_prettier)
        local local_eslint = vim.fn.fnamemodify('./node_modules/.bin/eslint', ':p')
        local local_eslint_stat = vim.loop.fs_stat(local_eslint)

        if local_prettier_stat then
          return prettier
        elseif local_eslint_stat then
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
        return nil
      end

      require('formatter').setup({
        filetype = {
          css = { prettier },
          html = { format_prettier_or_eslint },
          javascript = { format_prettier_or_eslint },
          javascriptreact = { format_prettier_or_eslint },
          json = { prettier },
          lua = { stylua },
          markdown = { prettier },
          prisma = {},
          sh = { shfmt },
          svelte = { format_prettier_or_eslint },
          sql = { format_sql },
          toml = { taplo },
          typescript = { format_prettier_or_eslint },
          typescriptreact = { format_prettier_or_eslint },
          yaml = { prettier },
          ['*'] = {
            require('formatter.filetypes.any').remove_trailing_whitespace,
          },
        },
      })
    end,
  },
}
