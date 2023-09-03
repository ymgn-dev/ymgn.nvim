return {
  {
    'numToStr/Comment.nvim',
    opts = {}, -- setup({}) と同等
    event = 'VeryLazy',
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
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {},
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
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

  {
    'zbirenbaum/copilot-cmp',
    dependencies = { 'hrsh7th/nvim-cmp' },
    config = true,
  },
}
