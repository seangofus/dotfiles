return {
  'zbirenbaum/copilot.lua',
  cmd = 'Copilot',
  event = { 'BufReadPost', 'BufNewFile' },
  config = function()
    require('copilot').setup {
      suggestion = { enabled = false },
      panel = { enabled = false },
      -- Node 26 (current default) breaks copilot-language-server's HTTP layer
      -- ("HTTP 200 response does not appear to originate from GitHub").
      -- Pin to Node 22 LTS installed via `brew install node@22`.
      copilot_node_command = '/opt/homebrew/opt/node@22/bin/node',
      filetypes = {
        markdown = true,
        yaml = true,
        ['*'] = true,
      },
    }
  end,
}
