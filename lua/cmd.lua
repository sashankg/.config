vim.api.nvim_create_user_command('Gundo', function()
  vim.cmd('G reset HEAD~')
end, {})

vim.api.nvim_create_user_command('Gpr', '!git push; gh pr create -w', {})

vim.api.nvim_create_user_command('Gfp', '!git push --force', {})

vim.api.nvim_create_autocmd({ 'BufEnter', 'ShellCmdPost' }, {
  pattern = { "fugitive://*/.git//" },
  command = ":G"
})
