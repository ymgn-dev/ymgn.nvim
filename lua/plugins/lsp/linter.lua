return {
  {
    'mfussenegger/nvim-lint',
    event = { 'BufReadPost', 'BufEnter' },
    config = function()
      require('lint').linters_by_ft = {
        css = { 'stylelint', 'codespell' },
        html = { 'codespell' },
        javascript = { 'eslint_d', 'codespell' },
        javascriptreact = { 'eslint_d', 'codespell' },
        json = { 'jsonlint', 'codespell' },
        lua = { 'luacheck', 'codespell' },
        markdown = { 'markdownlint', 'codespell' },
        prisma = { 'codespell' },
        sh = { 'shellcheck', 'codespell' },
        svelte = { 'eslint_d', 'codespell' },
        sql = { 'sqlfluff', 'codespell' },
        toml = { 'codespell' },
        typescript = { 'eslint_d', 'codespell' },
        typescriptreact = { 'eslint_d', 'codespell' },
        yaml = { 'yamllint', 'codespell' },
      }

      vim.api.nvim_create_autocmd({ 'BufEnter', 'TextChanged' }, {
        callback = function()
          require('lint').try_lint()
        end,
      })
    end,
  },
}
