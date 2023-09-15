return {
  {
    'mfussenegger/nvim-lint',
    event = { 'BufEnter', 'TextChanged', 'BufWritePost' },
    config = function()
      require('lint').linters_by_ft = {
        css = { 'stylelint', 'codespell' },
        html = { 'codespell' },
        javascript = { 'eslint', 'codespell' },
        javascriptreact = { 'eslint', 'codespell' },
        json = { 'jsonlint', 'codespell' },
        lua = { 'luacheck', 'codespell' },
        markdown = { 'markdownlint', 'codespell' },
        prisma = { 'codespell' },
        sh = { 'shellcheck', 'codespell' },
        svelte = { 'eslint', 'codespell' },
        sql = { 'sqlfluff', 'codespell' },
        toml = { 'codespell' },
        typescript = { 'eslint', 'codespell' },
        typescriptreact = { 'eslint', 'codespell' },
        vue = { 'eslint', 'codespell' },
        yaml = { 'yamllint', 'codespell' },
      }

      vim.api.nvim_create_autocmd({ 'BufEnter', 'TextChanged', 'BufWritePost' }, {
        callback = function()
          require('lint').try_lint()
        end,
      })
    end,
  },
}
