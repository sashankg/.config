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
  { 'tpope/vim-rhubarb',  lazy = true, cmd = { "GBrowse" } },
  require('plugins.gitsigns'),

  -- Editing utilities
  { 'tpope/vim-surround',   lazy = true, keys = { { "S", mode = "v" }, "ds", "cs" } },
  require('plugins.nerdcommenter'),
  'Raimondi/delimitMate',
  'tpope/vim-sleuth', -- Heuristically set buffer options
  'github/copilot.vim',

  -- Language utilities
  require('plugins.lspconfig'),
  require('plugins.formatter'),
  require('plugins.treesitter'),
  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = { 'hrsh7th/cmp-nvim-lsp' },
    config = function()
      local cmp = require('cmp')
      cmp.setup {
        mapping = cmp.mapping.preset.insert {
          ['<C-j>'] = cmp.mapping.select_next_item(),
          ['<C-k>'] = cmp.mapping.select_prev_item(),
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete {},
          ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          },
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end, { 'i', 's' }),
        },
        sources = {
          { name = 'nvim_lsp' },
        },
      }
    end,
  },

  -- UI
  require('plugins.lualine'),
  require('plugins.telescope'),
  { 'folke/which-key.nvim', opts = {} },
  {
    'navarasu/onedark.nvim',
    priority = 1000,
    config = function()
      require('onedark').setup {
        style = 'darker'
      }
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
  'nvim-treesitter/nvim-treesitter-context',
  { 'AndrewRadev/splitjoin.vim', lazy = true, keys = { { "gJ", "gS" } } },
  require('plugins.neotest'),
  require('plugins.dap'),
}, {})
