return {
  'josstei/whisk.nvim',
  config = function()
    require('whisk').setup {
      cursor = {
        duration = 250,
        easing = 'ease-out',
        enabled = false,
      },
      scroll = {
        duration = 400,
        easing = 'ease-out',
        enabled = true,
      },
      performance = { enabled = false },
      keymaps = {
        cursor = false,
        scroll = true,
      },
    }
  end,
}
