return {
  'nvim-tree/nvim-tree.lua',
  config = true,
  init = function()
    vim.keymap.set("n", "<C-t>", ':NvimTreeFindFile<CR>', {
      desc = "[Find] [S]ession"
    })
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'NvimTree',
      callback = function(ev)
        vim.keymap.set('n', '<C-t>', ':NvimTreeClose<CR>', { desc = 'Close Git status', buffer = ev.buf })
      end
    })
  end
}
