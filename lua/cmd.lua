vim.api.nvim_create_user_command('gundo', function()
  vim.cmd('G reset HEAD~')
end, {})

vim.api.nvim_create_user_command('gpr', '!git push; gh pr create -w', {})

vim.api.nvim_create_user_command('gpf', '!git push --force', {})
