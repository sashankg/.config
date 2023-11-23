return {
  'preservim/nerdcommenter',
  keys = {
    { "<leader>c", mode = { "n", "v" } },
  },
  init = function()
    vim.g.NERDSpaceDelims = 1
    vim.g.NERDDefaultAlign = 'left'
  end
}
