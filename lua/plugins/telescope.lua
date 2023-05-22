local function nmap(desc, keys, picker)
	vim.keymap.set('n', keys, picker, { desc = desc })
end

return {
	'nvim-telescope/telescope.nvim',
	branch = '0.1.x',
	dependencies = { 'nvim-lua/plenary.nvim' },
	opts =  {
		defaults = {
			mappings = {
				i = {
					["<C-J>"] = 'move_selection_next',
					["<C-K>"] = 'move_selection_previous',
				},
			},
		},
	},
	init = function (telescope)
		local builtin = require('telescope.builtin')
		local actions = require('telescope.actions')
		local state = require('telescope.actions.state')

		-- Enable telescope fzf native, if installed
		pcall(telescope.load_extension, 'fzf')

		-- See `:help telescope.builtin`
		nmap('Find keymap', '<leader>?', builtin.keymaps)
		nmap('Find files', '<leader><space>', builtin.find_files)
		nmap('Fuzzily search in current buffer', '<leader>/', function()
			-- You can pass additional configuration to telescope to change theme, layout, etc.
			builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
				winblend = 10,
				previewer = false,
			})
			end
		)
		nmap('Find buffers', '<leader>,', function ()
			builtin.buffers {
				attach_mappings = function(_, map)
					map('i', '<c-w>', 'delete_buffer')
					return true
				end
			}
			end
		)

		nmap('Search [G]it [F]iles', '<leader>gf', builtin.git_files)
		nmap('Search [G]it [S]tashes', '<leader>gs', builtin.git_stash)
		nmap('Search [G]it [B]ranches', '<leader>gb', builtin.git_branches)
		nmap('Search [G]it [C]ommits', '<leader>gc', function()
			builtin.git_commits {
				git_command = {"git","log","--pretty=oneline","--abbrev-commit", "-1000", "--","."},
			}
			end
		)
		nmap('Search [Buffer] [Commits]', '<leader>bc', function()
			local filename = vim.api.nvim_buf_get_name(0)
			builtin.git_bcommits {
				attach_mappings = function(_, map)
					map({"i", "n"}, "<CR>", function(bufnr)
						local commit = state.get_selected_entry().value
						actions.close(bufnr)
						vim.cmd('Gedit ' .. commit .. ':' .. filename)
					end)

					return true
				end
			}
			end
		)

		nmap('[S]earch [H]elp', '<leader>sh', builtin.help_tags)
		nmap('[S]earch current [W]ord', '<leader>sw', builtin.grep_string)
		nmap('[S]earch by [G]rep', '<leader>sg', builtin.live_grep)
		nmap('[S]earch [D]iagnostics', '<leader>sd', builtin.diagnostics)
		nmap('[D]ocument [S]ymbols', '<leader>ds', builtin.lsp_document_symbols)
		nmap('[W]orkspace [S]ymbols', '<leader>ws', builtin.lsp_dynamic_workspace_symbols)

		nmap('[G]o to [I]mplementations', 'gi', builtin.lsp_implementations)
		nmap('[G]o to [D]efinitions', 'gd', builtin.lsp_definitions)
		nmap('Go to Type Definitions', 'go', builtin.lsp_type_definitions)
		nmap('[G]o to [R]eferences', 'gr', builtin.lsp_references)
	end
}