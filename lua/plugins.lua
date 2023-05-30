-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  -- Git related plugins
  { 'tpope/vim-fugitive', lazy = true, cmd = { "Git", "G", "Gbrowse" }, },
  'tpope/vim-rhubarb',
  {
    -- Adds git releated signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '~' },
      },
      current_line_blame = true,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = true,
      },
      current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
      on_attach = function(bufnr)
        local gitsigns = require('gitsigns')
        vim.keymap.set('n', '[c', gitsigns.prev_hunk, { buffer = bufnr, desc = 'Go to Previous Hunk' })
        vim.keymap.set('n', ']c', gitsigns.next_hunk, { buffer = bufnr, desc = 'Go to Next Hunk' })
        vim.keymap.set('n', '<leader>gh', gitsigns.preview_hunk, { buffer = bufnr, desc = '[Git] Preview [H]unk' })
        vim.keymap.set('n', '<leader>gl', function()
            gitsigns.blame_line { full = true, ignore_whitespace = true }
          end,
          { buffer = bufnr, desc = '[G]it B[l]ame' })
      end,
    },
  },

  -- Editing utilities
  { 'tpope/vim-surround', lazy = true, keys = { { "S", mode = "v" }, "ds", "cs" } },
  'preservim/nerdcommenter',
  'Raimondi/delimitMate',
  'tpope/vim-sleuth',
  'github/copilot.vim',

  -- Language utilities
  require('plugins.lspconfig'),
  require('plugins.formatter'),
  require('plugins.treesitter'),
  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip',
      'rafamadriz/friendly-snippets' },
  },

  -- UI
  require('plugins.lualine'),
  require('plugins.telescope'),
  { 'folke/which-key.nvim', opts = {} },
  {
    'navarasu/onedark.nvim',
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'onedark'
    end,
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    opts = {
      char = '┊',
      show_trailing_blankline_indent = false,
    },
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    -- NOTE: If you are having trouble with this installation,
    --       refer to the README for telescope-fzf-native for more instructions.
    build = 'make',
    cond = function()
      return vim.fn.executable 'make' == 1
    end,
  },

}, {})
