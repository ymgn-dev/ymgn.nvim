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
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable('make') == 1
        end,
      },
    },
    config = function()
      require('telescope').setup({
        defaults = {
          initial_mode = 'normal',
          mappings = {
            i = { ['<C-u>'] = false, ['<C-d>'] = false },
          },
        },
        extensions = {
          file_browser = { theme = 'dropdown', hijack_netrw = true },
        },
      })
      require('telescope').load_extension('fzf')
      require('telescope').load_extension('file_browser')
    end,
    keys = {
      { '<leader>fo', '<cmd>Telescope oldfiles<cr>', desc = '[F]ind oldfiles' },
      { '<leader>fb', '<cmd>Telescope buffers<cr>',  desc = '[F]ind existing [B]uffers' },
      {
        '<leader>/',
        function()
          require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown({
            winblend = 10, previewer = false, }))
        end,
        desc = '[/] Fuzzily search in current buffer'
      },
      { '<leader>gf', '<cmd>Telescope git_files<cr>', desc = 'Search [G]it [F]iles' },
    },
    -- keys = {
    --   { '<leader>ff',  require('telescope.builtin').find_files,  desc = '[F]ind [F]iles' },
    --   { '<leader>fh',  require('telescope.builtin').help_tags,   desc = '[F]ind [H]elp' },
    --   { '<leader>fcw', require('telescope.builtin').grep_string, desc = '[F]ind [C]urrent [W]ord' },
    --   { '<leader>fw',  require('telescope.builtin').live_grep,   desc = '[F]ind by [G]rep' },
    --   { '<leader>fd',  require('telescope.builtin').diagnostics, desc = '[F]ind [D]iagnostics' },
    --   {
    --     '<C-n>',
    --     ':Telescope file_browser path=%:p:h select_buffer=true<CR>',
    --     noremap = true,
    --     desc = 'Open file browser'
    --   },
    -- },
  },

  {
    'nvim-telescope/telescope-file-browser.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' },
    event = 'VeryLazy',
  },

  { "nvim-tree/nvim-web-devicons", lazy = true },

  { "MunifTanjim/nui.nvim",        lazy = true },
}
