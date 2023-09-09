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
      local prettierd = require('formatter.defaults').prettierd
      local function format_sql()
        local sqlfluff_cfg_path = vim.fn.getcwd() .. '/.sqlfluff.cfg'

        if vim.fn.filereadable(vim.fn.expand(sqlfluff_cfg_path)) ~= 1 then
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
          sql = { format_sql },
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
