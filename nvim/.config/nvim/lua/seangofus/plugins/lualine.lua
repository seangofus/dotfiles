return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('lualine').setup {
      options = {
        icons_enabled = true,
        -- theme = 'material',
        globalstatus = true,
      },
      sections = {
        lualine_b = {
          'branch',
          'diff',
          'diagnostics',
        },
        lualine_c = {
          {
            'filename',
            path = 1,
          },
        },
        lualine_x = {
          'filetype',
        },
      },
    }
  end,
}
