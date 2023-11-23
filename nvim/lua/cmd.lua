vim.api.nvim_create_user_command('Gundo', function()
  vim.cmd('G reset HEAD~')
end, {})

vim.api.nvim_create_user_command('Gpr', '!git push; gh pr create -w', {})

vim.api.nvim_create_user_command('Gfp', '!git push --force', {})

local fugitiveRow = 1

local function fugitive_jump()
  local line = math.min(vim.api.nvim_buf_line_count(0), fugitiveRow)
  if line > 3 then
    vim.api.nvim_win_set_cursor(0, { line, 0 })
  else
    vim.api.nvim_feedkeys('gU', 'm', false)
  end
end

vim.api.nvim_create_autocmd({ 'BufEnter', 'ShellCmdPost' }, {
  pattern = { "fugitive://*/.git//" },
  callback = function()
    vim.cmd(":G")
    fugitive_jump()
  end
})

vim.api.nvim_create_autocmd('BufNew', {
  pattern = 'fugitive://*/.git//',
  callback = function()
    fugitive_jump()
  end
})

vim.api.nvim_create_autocmd('BufLeave', {
  pattern = 'fugitive://*/.git//',
  callback = function(ev)
    fugitiveRow = unpack(vim.api.nvim_win_get_cursor(0))
  end
})
-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- vim.api.nvim_create_autocmd('BufWritePost', {
--   pattern = { '*.js', '*.jsx', '*.ts', '*.tsx' },
--   callback = function()
--     vim.fn.jobstart('eslint_d --stdin --fix-to-stdout < ' .. vim.fn.expand('%'), {
--       on_stdout = function(j, code)
--         vim.print(j, code)
--       end,
--     })
--   end,
-- })
