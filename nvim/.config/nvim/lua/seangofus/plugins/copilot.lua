return {
  'zbirenbaum/copilot.lua',
  cmd = 'Copilot',
  event = { 'BufReadPost', 'BufNewFile' },
  config = function()
    require('copilot').setup {
      suggestion = { enabled = false },
      panel = { enabled = false },
      -- Node 26 (current homebrew default) breaks copilot-language-server's
      -- HTTP layer ("HTTP 200 response does not appear to originate from
      -- GitHub"). Pin to the n-managed node at /usr/local/bin/node which
      -- is currently v22 LTS.
      copilot_node_command = '/usr/local/bin/node',
      -- Pin the inline completion model. As of now, gpt-41-copilot is the only
      -- model GitHub exposes with the "completion" scope (Claude/GPT-5/etc.
      -- are chat/agent/inline-edit only). Pinning prevents silent drift.
      copilot_model = 'gpt-41-copilot',
      filetypes = {
        markdown = true,
        yaml = true,
        ['*'] = true,
      },
    }
  end,
}
