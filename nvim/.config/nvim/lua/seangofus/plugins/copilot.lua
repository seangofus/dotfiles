return {
  'zbirenbaum/copilot.lua',
  cmd = 'Copilot',
  event = { 'BufReadPost', 'BufNewFile' },
  config = function()
    require('copilot').setup {
      suggestion = { enabled = false },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
        yaml = true,
        ['*'] = true,
      },
    }
  end,
}
