return {
  -- Adds git releated signs to the gutter, as well as utilities for managing changes
  'lewis6991/gitsigns.nvim',
  opts = {
    -- See `:help gitsigns.txt`
    signs = {
      add = { text = '+' },
      change = { text = '~' },
    },
    current_line_blame = true,
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = 'eol',   -- 'eol' | 'overlay' | 'right_align'
      delay = 1000,
      ignore_whitespace = true,
    },
    current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
    on_attach = function(bufnr)
      local gitsigns = require('gitsigns')
      vim.keymap.set('n', '[c', gitsigns.prev_hunk, { buffer = bufnr, desc = 'Go to Previous Hunk' })
      vim.keymap.set('n', ']c', gitsigns.next_hunk, { buffer = bufnr, desc = 'Go to Next Hunk' })
      vim.keymap.set('n', '<leader>gh', gitsigns.preview_hunk, { buffer = bufnr, desc = '[Git] Preview [H]unk' })
      vim.keymap.set('n', '<leader>gr', gitsigns.reset_hunk, { buffer = bufnr, desc = '[Git] [R]eset Hunk' })
      vim.keymap.set('n', '<leader>gl', function()
          gitsigns.blame_line { full = true, ignore_whitespace = true }
        end,
        { buffer = bufnr, desc = '[G]it B[l]ame' })
    end,
  },
}
