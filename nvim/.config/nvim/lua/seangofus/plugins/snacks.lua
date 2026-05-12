return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    picker = {
      enabled = true,
      ui_select = true, -- replaces dressing.nvim (vim.ui.select)
    },
    input = { enabled = true }, -- replaces dressing.nvim (vim.ui.input)
    indent = { enabled = true }, -- replaces indent-blankline.nvim
    notifier = { enabled = true, timeout = 3000 }, -- replaces nvim-notify
    zen = {}, -- for zoom (replaces vim-maximizer)
  },
  keys = {
    -- File finding (replaces telescope)
    { '<leader>ff', function() Snacks.picker.files { hidden = true } end, desc = 'Fuzzy find files in cwd' },
    { '<leader>fr', function() Snacks.picker.recent() end, desc = 'Fuzzy find recent files' },
    { '<leader>fs', function() Snacks.picker.grep() end, desc = 'Find string in cwd' },
    { '<leader>fc', function() Snacks.picker.grep_word() end, desc = 'Find string under cursor in cwd' },

    -- Git
    { '<leader>gb', function() Snacks.picker.git_branches() end, desc = 'Navigate git branches' },

    -- Zoom (replaces vim-maximizer)
    { '<leader>sm', function() Snacks.zen.zoom() end, desc = 'Maximize/minimize a split' },

    -- Notifications
    { '<leader>un', function() Snacks.notifier.hide() end, desc = 'Dismiss all notifications' },
  },
}
