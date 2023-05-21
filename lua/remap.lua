vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Pane navigation
vim.keymap.set('n', '<C-h>', '<C-W><C-h>', { desc = 'Cursor to left pane' })
vim.keymap.set('n', '<C-j>', '<C-W><C-j>', { desc = 'Cursor to lower pane' })
vim.keymap.set('n', '<C-k>', '<C-W><C-k>', { desc = 'Cursor to upper pane' })
vim.keymap.set('n', '<C-l>', '<C-W><C-l>', { desc = 'Cursor to right pane' })

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Insert mode navigation
vim.keymap.set('i', '<C-h>', '<Left>')
vim.keymap.set('i', '<C-j>', '<Down>')
vim.keymap.set('i', '<C-k>', '<Up>')
vim.keymap.set('i', '<C-l>', '<Right>')
