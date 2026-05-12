return {
  'NeogitOrg/neogit',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'sindrets/diffview.nvim',
  },
  config = function()
    local neogit = require 'neogit'

    neogit.setup {
      status = {
        recent_commit_include_author_info = true,
      },
      commit_editor = {
        kind = 'vsplit',
      },
      integrations = {
        diffview = true,
      },
    }

    vim.keymap.set('n', '<leader>gt', "<cmd>lua require('neogit').open()<cr>", { desc = 'Open NeoGit' })
  end,
}
