vim.api.nvim_set_hl(0, "LuaLineTsCarets", { fg = "blue" })
vim.cmd("syntax match LuaLineTsCarets /\"/")

local firstWordTransform = function(text)
  return string.match(text, '(%w+)')
end
local treeFields = {
  attribute = {
    transform = firstWordTransform
  },
  name = {
    icon = function(node)
      if string.sub(vim.treesitter.get_node_text(node:parent(), 0), 1, 1) == "<" then
        return "󰅴"
      end
      return "󰫧"
    end
  },
  key = { icon = "󰅩" },
  ["function"] = { icon = "󰊕" },
  type = {},
  open_tag = {
    icon = "󰅴",
    transform = firstWordTransform
  }
}

local treeFieldsOrder = {
  'attribute',
  'name',
  'key',
  'function',
  'type',
  'open_tag'
}

return {
  -- Set lualine as statusline
  'nvim-lualine/lualine.nvim',
  -- See `:help lualine.txt`
  opts = {
    options = {
      icons_enabled = false,
      theme = 'onedark',
      component_separators = '|',
      section_separators = '',
      globalstatus = true
    },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = { 'branch', 'diff', 'diagnostics' },
      lualine_c = {
        function()
          return vim.fn.getcwd()
        end
      },
      lualine_x = { 'filetype' },
      lualine_y = { 'location' },
      lualine_z = {},
    },
    winbar = {
      lualine_b = { '%f' }
    },
    inactive_winbar = {
      lualine_c = { '%f' }
    }
  },
}
