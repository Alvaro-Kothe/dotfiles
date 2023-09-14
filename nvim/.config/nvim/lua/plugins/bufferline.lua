local M = { 'akinsho/bufferline.nvim', version = '*', dependencies = 'nvim-tree/nvim-web-devicons' }

function M.config()
  local bufferline = require 'bufferline'
  bufferline.setup {
    options = {
      close_command = 'bdelete! %d', -- can be a string | function, | false see "Mouse actions"
      right_mouse_command = 'bdelete! %d', -- can be a string | function | false, see "Mouse actions"
      left_mouse_command = 'buffer %d', -- can be a string | function, | false see "Mouse actions"
      middle_mouse_command = nil, -- can be a string | function, | false see "Mouse actions"
      diagnostics = 'nvim_lsp',
      always_show_bufferline = false,
      offsets = {
        {
          filetype = 'neo-tree',
          text = 'Neo-tree',
          highlight = 'Directory',
          text_align = 'left',
        },
      },
    },
  }
end

return M
