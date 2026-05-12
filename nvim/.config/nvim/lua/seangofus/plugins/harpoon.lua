return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  opts = {},
  keys = {
    {
      '<leader>hm',
      function()
        require('harpoon'):list():add()
      end,
      desc = 'Harpoon mark file',
    },
    {
      '<leader>hn',
      function()
        require('harpoon'):list():next()
      end,
      desc = 'Harpoon next',
    },
    {
      '<leader>hp',
      function()
        require('harpoon'):list():prev()
      end,
      desc = 'Harpoon prev',
    },
    {
      '<leader>hv',
      function()
        local harpoon = require 'harpoon'
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end,
      desc = 'Harpoon quick menu',
    },
  },
}
