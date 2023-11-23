return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "antoinemadec/FixCursorHold.nvim",
    "haydenmeade/neotest-jest",
    "nvim-neotest/neotest-go",
  },
  opts = function()
    return {
      adapters = {
        require('neotest-jest'),
        require('neotest-go'),
      }
    }
  end,
  lazy = true,
  cmd = { "Neotest" }
}
