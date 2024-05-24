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
        typescript = {
          require('formatter.filetypes.javascript').eslint_d,
        },
        typescriptreact = {
          require('formatter.filetypes.javascriptreact').eslint_d,
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
