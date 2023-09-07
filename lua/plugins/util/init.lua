return {
  {
    'numToStr/Comment.nvim',
    opts = {}, -- setup({}) と同等
    event = { 'BufAdd', 'BufReadPost' },
  },

  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {
      check_ts = true,
    },
  },

  {
    'windwp/nvim-ts-autotag',
    event = 'InsertEnter',
    opts = {},
    ft = {
      'typescriptreact',
      'javascriptreact',
      'svelte',
      'html',
      'javascript',
      'typescript',
      'tsx',
      'jsx',
      'markdown',
    },
  },

  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    build = ':Copilot auth',
    event = 'InsertEnter',
    opts = {
      panel = { enabled = false },
      suggestion = {
        enabled = true,
        auto_trigger = true,
        keymap = {
          accept = '<Tab>',
          close = '<Esc>',
          next = '<C-n>',
          prev = '<C-p>',
          select = '<CR>',
          dismiss = '<C-x>',
        },
      },
    },
  },
}
