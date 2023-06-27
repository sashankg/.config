local function nmap(desc, keys, picker)
	vim.keymap.set('n', keys, picker, { desc = desc })
end

return {
	'nvim-telescope/telescope.nvim',
	branch = '0.1.x',
	dependencies = { 'nvim-lua/plenary.nvim' },
	opts = {
		defaults = {
			mappings = {
				i = {
					["<C-J>"] = 'move_selection_next',
					["<C-K>"] = 'move_selection_previous',
				},
			},
			dynamic_preview_title = true,
		},
	},
	init = function(telescope)
		local builtin = require('telescope.builtin')
		local actions = require('telescope.actions')
		local state = require('telescope.actions.state')

		-- Enable telescope fzf native, if installed
		pcall(telescope.load_extension, 'fzf')

		-- See `:help telescope.builtin`
		nmap('Resume', '<leader>,', builtin.resume)
		nmap('Find keymap', '<leader>?', builtin.keymaps)
		nmap('Find buffers', '<leader><space>', function()
			builtin.buffers {
				sort_mru = true,
				attach_mappings = function(_, map)
					map('i', '<c-w>', 'delete_buffer')
					return true
				end
			}
		end
		)
		nmap('[F]ind [F]iles', '<leader>ff', builtin.find_files)
		nmap('[F]ind [H]elp', '<leader>fh', builtin.help_tags)
		nmap('[F]ind current [W]ord', '<leader>fw', builtin.grep_string)
		nmap('[F]ind by [G]rep', '<leader>fg', builtin.live_grep)
		nmap('[F]ind [D]iagnostics', '<leader>fd', builtin.diagnostics)
		nmap('Fuzzily search in current buffer', '<leader>/', function()
			-- You can pass additional configuration to telescope to change theme, layout, etc.
			builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
				winblend = 10,
				previewer = false,
			})
		end
		)

		nmap('Search [G]it [F]iles', '<leader>gf', builtin.git_files)
		nmap('Search [G]it [S]tashes', '<leader>gs', builtin.git_stash)
		nmap('Search [G]it [B]ranches', '<leader>gb', function()
			builtin.git_branches {
				attach_mappings = function(_, map)
					map({ "i", "n" }, "<CR>", function(bufnr)
						local branch = state.get_selected_entry().value
						actions.close(bufnr)
						vim.cmd('G checkout ' .. branch)
					end)
					map({ "i", "n" }, "<C-a>", function(bufnr)
						local branch = state.get_current_line()
						actions.close(bufnr)
						vim.cmd('G checkout -b ' .. branch)
					end)
					return true
				end
			}
		end)
		nmap('Search [G]it [C]ommits', '<leader>gc', function()
			builtin.git_commits {
				git_command = { "git", "log", "--pretty=oneline", "--abbrev-commit", "-1000", "--", "." },
			}
		end
		)
		nmap('Search [Buffer] [Commits]', '<leader>bc', function()
			local filename = vim.api.nvim_buf_get_name(0)
			builtin.git_bcommits {
				attach_mappings = function(_, map)
					map({ "i", "n" }, "<CR>", function(bufnr)
						local commit = state.get_selected_entry().value
						actions.close(bufnr)
						vim.cmd('Gedit ' .. commit .. ':' .. filename)
					end)

					return true
				end
			}
		end
		)
	end
}
