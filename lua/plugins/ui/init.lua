return {
  {
    'sainnhe/everforest',
    event = 'VeryLazy',
    init = function()
      vim.cmd.colorscheme('everforest')
    end,
  },

  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    opts = {
      options = {
        theme = 'everforest',
      }
    }
  },

  {
    'lukas-reineke/indent-blankline.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {
      char = '┊',
      show_trailing_blankline_indent = false,
    },
  },

  {
    'romgrk/barbar.nvim',
    event = { 'BufReadPost', 'BufAdd', 'BufNewFile' },
    opts = { animation = false },
    dependencies = {
      'lewis6991/gitsigns.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    init = function()
      vim.g.barbar_auto_setup = false
    end,
    keys = {
      { '<S-Tab>',   '<Cmd>BufferPrevious<Cr>', desc = 'barbar BufferPrevious', { noremap = true, silent = true } },
      { '<Tab>',     '<Cmd>BufferNext<Cr>',     desc = 'barbar BufferNext',     { noremap = true, silent = true } },
      { '<Leader>x', '<Cmd>BufferClose<Cr>',    desc = 'barbar BufferClose',    { noremap = true, silent = true } },
    },
  },

  {
    'akinsho/toggleterm.nvim',
    event = 'VeryLazy',
    opts = {},
    config = function()
      require('toggleterm').setup({
        open_mapping = [[<A-i>]],
        direction = 'float',
        highlights = {
          NormalFloat = { guibg = '#122212', guifg = '#FCFCFC' },
        },
        float_opts = { border = 'shadow' },
      })
    end,
  },

  { "nvim-tree/nvim-web-devicons", lazy = true },

  { "MunifTanjim/nui.nvim",        lazy = true },
}
