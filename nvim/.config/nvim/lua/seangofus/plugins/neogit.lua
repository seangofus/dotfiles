return {
  'NeogitOrg/neogit',
  dependencies = {
    'nvim-lua/plenary.nvim', -- required
    'nvim-telescope/telescope.nvim', -- optional
    'sindrets/diffview.nvim', -- optional
    'ibhagwan/fzf-lua', -- optional
  },
  config = function()
    local neogit = require 'neogit'
    local keymap = vim.keymap

    neogit.setup {
      status = {
        recent_commit_include_author_info = true,
      },
      commit_editor = {
        kind = 'vsplit',
      },
      integrations = {
        telescope = true,
      },
    }

    keymap.set('n', '<leader>gt', "<cmd>lua require('neogit').open()<cr>", { desc = 'Open NeoGit' })
  end,
}
