vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

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

vim.keymap.set('n', '<C-s>', ':w<CR>', { desc = 'Save buffer' })

vim.keymap.set('n', '<C-g>', ':vertical G<CR>', { desc = 'Open Git status' })
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'Fugitive',
  callback = function(ev)
    vim.keymap.set('n', '<C-g>', ':bd<CR>', { desc = 'Close Git status', buffer = ev.buf })
    vim.keymap.set('n', 'cc', function()
      vim.ui.input({ prompt = 'Commit message: ' }, function(msg)
        if not msg then
          return
        end
        vim.cmd('G! commit -m "' .. msg .. '"')
      end)
    end, { desc = 'Close Git status', buffer = ev.buf })
  end
})

vim.keymap.set('n', '<leader>gp', function()
  local fname = vim.api.nvim_buf_get_name(0)
  local lnum = vim.api.nvim_win_get_cursor(0)[1]
  local resp = vim.api.nvim_exec2('!git blame -w -L ' .. lnum .. ',+1 --line-porcelain ' .. fname, { output = true })
  local prnum = string.match(resp.output, '\nsummary.*%(#(%d+)%)')
  if prnum ~= nil then
    vim.cmd('!gh pr view ' .. prnum .. ' -w')
  else
    vim.notify('No PR found for this line')
  end
end, { desc = '[G]it Go to [P]R' })

vim.keymap.set('n', '<leader>gm', function()
  vim.cmd("G checkout master")
end, { desc = '[G]it checkout [M]aster' })

vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '}', '}zz')
vim.keymap.set('n', '{', '{zz')

vim.keymap.set('n', '<Esc>', ':noh<CR><Esc>', { silent = true })
