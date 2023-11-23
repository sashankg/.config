return {
  'mhartington/formatter.nvim',
  config = function(_)
    require('formatter').setup {
      logging = true,
      log_level = vim.log.levels.WARN,
      filetype = {
        go = {
          require('formatter.filetypes.go').golines,
        },
      },
    }
  end,
  init = function()
    vim.api.nvim_create_autocmd('BufWritePost', {
      command = 'FormatWrite',
    })
  end
}
