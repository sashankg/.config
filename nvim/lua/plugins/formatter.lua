local function eslint_d()
  return {
    exe = 'eslint_d',
    args = { '--stdin', '--stdin-filename', vim.api.nvim_buf_get_name(0), '--fix-to-stdout' },
    stdin = true,
  }
end

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
          eslint_d,
        },
        typescriptreact = {
          eslint_d,
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
