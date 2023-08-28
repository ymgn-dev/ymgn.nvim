-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'romgrk/barbar.nvim',
    dependencies = {
      'lewis6991/gitsigns.nvim',     -- OPTIONAL: for git status
      'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
    },
    init = function()
      vim.g.barbar_auto_setup = false
    end,
    opts = {
      -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
      -- animation = true,
      -- insert_at_start = true,
      -- …etc.
    },
    version = '^1.0.0', -- optional: only update when a new 1.x version is released
    event = { 'BufReadPost', 'BufAdd', 'BufNewFile' },
  },

  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    build = ':Copilot auth',
    event = 'InsertEnter',
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = true,
        keymap = {
          accept = '<Tab>',
          close = '<Esc>',
          next = '<C-J>',
          prev = '<C-K>',
          select = '<CR>',
          dismiss = '<C-X>',
        },
      },
      panel = {
        enabled = false,
      },
    },
  },

  {
    'zbirenbaum/copilot-cmp',
    dependencies = {
      'hrsh7th/nvim-cmp',
    },
    config = true,
  },
}
