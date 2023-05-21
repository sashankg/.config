require("sashankg.remap")
require("sashankg.vim")

vim.api.nvim_create_user_command('PR', '!git push; gh pr create -w', {})

