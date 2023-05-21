return {
	-- lua helper functions
	'nvim-lua/plenary.nvim',
	{
		-- fuzzy finder over lists
		'nvim-telescope/telescope.nvim',
		init = function(_)
			local builtin = require('telescope.builtin')
			vim.keymap.set(
				'n',
				'<leader>ff',
				function()
					builtin.find_files {
					}
				end, {})
			vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
			vim.keymap.set('n', '<leader>fb', function()
				builtin.buffers {
					attach_mappings = function(_, map)
						map('i', '<c-w>', 'delete_buffer')
						return true
					end
				}
			end, {})
			vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
			vim.keymap.set('n', '<leader>ft', builtin.treesitter, {})

			vim.keymap.set('n', '<leader>gb', builtin.git_branches, {})
			vim.keymap.set('n', '<leader>gs', builtin.git_stash, {})
			vim.keymap.set('n', '<leader>bc', builtin.git_bcommits, {})

			vim.keymap.set('n', 'gi', builtin.lsp_implementations, {})
			vim.keymap.set('n', 'gd', builtin.lsp_definitions, {})
			vim.keymap.set('n', 'go', builtin.lsp_type_definitions, {})
			vim.keymap.set('n', 'gr', builtin.lsp_references, {})

			local actions = require('telescope.actions')
			require('telescope').setup({
				defaults = {
					mappings = {
						i = {
							["<C-J>"] = actions.move_selection_next,
							["<C-K>"] = actions.move_selection_previous,
						}
					}
				}
			})
		end
	},
	{
		-- git helpers
		'tpope/vim-fugitive',
		lazy = true,
		cmd = { "Git", "G", "Gbrowse" },
	},
	'tpope/vim-surround',
	{
		-- syntax tree
		'nvim-treesitter/nvim-treesitter',
		build = ":TSUpdate",
		main = "nvim-treesitter.configs",
		opts = {
			-- Install parsers synchronously (only applied to `ensure_installed`)
			sync_install = false,

			-- Automatically install missing parsers when entering buffer
			-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
			auto_install = true,

			highlight = {
				enable = true,
				-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
				-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
				-- Using this option may slow down your editor, and you may see some duplicate highlights.
				-- Instead of true it can also be a list of languages
				additional_vim_regex_highlighting = false,
			},
		}

	},
	{
		-- language server
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v2.x',
		dependencies = {
			-- LSP Support
			{ 'neovim/nvim-lspconfig' }, -- Required
			{
				-- Optional
				'williamboman/mason.nvim',
				build = function()
					pcall(vim.cmd, 'MasonUpdate')
				end,
			},
			{ 'williamboman/mason-lspconfig.nvim' }, -- Optional

			-- Autocompletion
			{ 'hrsh7th/nvim-cmp' }, -- Required
			{ 'hrsh7th/cmp-nvim-lsp' }, -- Required
			{ 'L3MON4D3/LuaSnip' }, -- Required
		},
		config = function()
			local lsp = require('lsp-zero').preset('recommended')

			lsp.on_attach(function(_, bufnr)
				lsp.default_keymaps({ buffer = bufnr })
			end)

			-- (Optional) Configure lua language server for neovim
			local lspconfig = require('lspconfig')

			lspconfig.lua_ls.setup(lsp.nvim_lua_ls())
			lspconfig.eslint.setup({
				on_attach = function (_, bufnr)
					vim.api.nvim_create_autocmd('BufWritePre', {
						buffer = bufnr,
						command = 'EslintFixAll',
					})
				end,
			})
			lspconfig.gopls.setup({
				on_attach = function (_, bufnr)
					print(vim.api.nvim_buf_get_name(bufnr))
					vim.api.nvim_create_autocmd('BufWritePre', {
						buffer = bufnr,
						callback = function (_)
							vim.api.nvim_command('!~/workspace/scio/tools/golang-sort-imports.sh ' .. vim.api.nvim_buf_get_name(bufnr))
						end
					})
				end,
			})
			lsp.format_on_save({
				servers = {
					['gopls'] = {'go'},
				},
			})
			lsp.setup()
		end,
	},
	'github/copilot.vim',
	{
		-- shows inline blame
		'rhysd/git-messenger.vim',
		lazy = true,
		cmd = { "GitMessenger" },
		keys = { "<leader>gm" },
	},
	{ 'tpope/vim-rhubarb', cmd = { 'Gbrowse' } },
	'airblade/vim-gitgutter',
	{
		'preservim/nerdtree',

	},
	{
		'sainnhe/sonokai',
		config = function()
			if vim.fn.has('termguicolors') == 1 then
				vim.opt.termguicolors = true
			end
			vim.g.sonokai_style = 'shusia'
			vim.g.sonokai_better_performance = 1
			vim.cmd('colorscheme sonokai')
		end,
	}
}
