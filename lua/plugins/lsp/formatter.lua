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

      require('formatter').setup({
        filetype = {
          css = { prettier },
          html = { prettier },
          javascript = { prettier },
          javascriptreact = { prettier },
          json = { prettier },
          lua = { stylua },
          markdown = { prettier },
          prisma = {},
          sh = { shfmt },
          svelte = { prettier },
          sql = { format_sql },
          toml = { taplo },
          typescript = { prettier },
          typescriptreact = { prettier },
          yaml = { prettier },
          ['*'] = {
            require('formatter.filetypes.any').remove_trailing_whitespace,
          },
        },
      })
    end,
  },
}
