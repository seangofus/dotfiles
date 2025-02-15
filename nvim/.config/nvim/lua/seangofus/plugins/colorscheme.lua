return {
  -- {
  --   "neanias/everforest-nvim",
  --   version = false,
  --   lazy = false,
  --   priority = 1000, -- make sure to load this before all the other start plugins
  --   -- Optional; default configuration will be used if setup isn't called.
  --   config = function()
  --     vim.cmd([[colorscheme everforest]])
  --   end,
  -- },
  'rose-pine/neovim',
  name = 'rose-pine',
  priority = 1000,
  config = function()
    vim.cmd 'colorscheme rose-pine-main'
  end,
}
