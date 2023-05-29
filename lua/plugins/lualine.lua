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
    },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = { 'branch', 'diff', 'diagnostics' },
      lualine_c = { 'filename' },
      lualine_x = { 'filetype' },
      lualine_y = { 'progress' },
      lualine_z = { 'location' }
    },
    tabline = {
      lualine_b = { '%f' },
      lualine_c = {
        {
          function()
            if not vim.treesitter._has_parser(0) then
              return ""
            end
            local path = ''
            local node = vim.treesitter.get_node()
            local prev = nil
            repeat
              for _, name in ipairs(treeFieldsOrder) do
                local opts = treeFields[name]
                local appendNode = function(n)
                  local text = vim.treesitter.get_node_text(n, 0)
                  if opts.transform ~= nil then
                    text = opts.transform(text)
                  end
                  if opts.icon ~= nil then
                    local icon
                    if type(opts.icon) == 'function' then
                      icon = opts.icon(n)
                    else
                      icon = opts.icon
                    end
                    text = icon .. ' ' .. text
                  end
                  return text .. ' ' .. path
                end

                local children = node:field(name)
                if #children == 1 then
                  path = appendNode(children[1])
                else
                  for _, child in ipairs(children) do
                    if child:equal(prev) then
                      path = appendNode(child)
                    end
                  end
                end
              end

              prev = node
              node = node:parent()
            until node == nil
            return string.sub(path, 0, -5)
          end,
          color = 'LuaLineTsCarets'
        } },
    }
  },
}
