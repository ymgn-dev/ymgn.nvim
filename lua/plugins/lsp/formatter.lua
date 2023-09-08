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
      local prettierd = require('formatter.defaults').prettierd
      local function sql_formatter()
        -- https://github.com/sql-formatter-org/sql-formatter
        return {
          exe = 'sql-formatter',
          args = {
            util.escape_path(util.get_current_buffer_file_path()),
            '--config',
            '~/.config/sql-formatter/config.json',
          },
          stdin = true,
        }
      end

      require('formatter').setup({
        logging = true,
        log_level = vim.log.levels.WARN,
        filetype = {
          css = { prettierd },
          html = { prettierd },
          javascript = { prettierd },
          javascriptreact = { prettierd },
          json = { prettierd },
          lua = { stylua },
          markdown = { prettierd },
          prisma = {},
          sh = { shfmt },
          svelte = { prettierd },
          sql = { sql_formatter },
          toml = { taplo },
          typescript = { prettierd },
          typescriptreact = { prettierd },
          yaml = { prettierd },
          ['*'] = {
            require('formatter.filetypes.any').remove_trailing_whitespace,
          },
        },
      })
    end,
  },
}
