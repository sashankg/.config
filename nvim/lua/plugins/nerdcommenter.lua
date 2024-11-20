return {
  'preservim/nerdcommenter',
  lazy = true,
  keys = {
    { "<leader>c", mode = { "n", "v" } },
  },
  init = function()
    vim.g.NERDSpaceDelims = 1
    vim.g.NERDDefaultAlign = 'left'
  end
}
