-- Install package managerplu
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
  { 'tpope/vim-fugitive', lazy = true, cmd = { "Git", "G", "GBrowse" }, },
  'tpope/vim-rhubarb',
  require('plugins.gitsigns'),

  -- Editing utilities
  { 'tpope/vim-surround', lazy = true, keys = { { "S", mode = "v" }, "ds", "cs" } },
  require('plugins.nerdcommenter'),
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
    main = 'ibl',
    opts = {
      indent = {
        char = "┊"
      },
      scope = {
        show_start = false,
        show_end = false
      }
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
  require('plugins.nvimtree'),
  'nvim-treesitter/nvim-treesitter-context',
  'AndrewRadev/splitjoin.vim',
  require('plugins.neotest'),
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      { "r",     mode = "o",          function() require("flash").remote() end,            desc = "Remote Flash" },
      { "R",     mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" },      function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
    },
  }
}, {})
