local function project_root()
  return vim.fs.root(0, {
    '.git',
    'package.json',
    'pnpm-workspace.yaml',
    'go.mod',
    'Cargo.toml',
    'pyproject.toml',
  }) or vim.uv.cwd()
end

return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    picker = {
      enabled = true,
      ui_select = true, -- replaces dressing.nvim (vim.ui.select)
      matcher = {
        frecency = true, -- rank recently/frequently used files higher
        cwd_bonus = true, -- prefer files in cwd
      },
      sources = {
        files = {
          hidden = true, -- include dotfiles (still respects .gitignore)
          ignored = false, -- still hide gitignored files (node_modules, .nx, etc.)
          follow = false,
        },
        grep = {
          regex = false, -- literal input by default; use <leader>fS for regex
          hidden = true,
        },
        lsp_references = {
          auto_confirm = false, -- always show picker even for a single result
          include_current = true,
        },
        lsp_definitions = { auto_confirm = false },
        lsp_implementations = { auto_confirm = false },
        lsp_type_definitions = { auto_confirm = false },
      },
    },
    input = { enabled = true }, -- replaces dressing.nvim (vim.ui.input)
    indent = { enabled = true }, -- replaces indent-blankline.nvim
    notifier = { enabled = true, timeout = 3000 }, -- replaces nvim-notify
    zen = {}, -- for zoom (replaces vim-maximizer)
  },
  keys = {
    -- File finding (replaces telescope) -- always rooted at project root
    { '<leader>ff', function() Snacks.picker.files { cwd = project_root() } end, desc = 'Find files (project root)' },
    { '<leader>fr', function() Snacks.picker.recent() end, desc = 'Recent files' },
    { '<leader>fs', function() Snacks.picker.grep { cwd = project_root() } end, desc = 'Grep (literal, project root)' },
    { '<leader>fS', function() Snacks.picker.grep { cwd = project_root(), regex = true, live = true } end, desc = 'Grep (regex, project root)' },
    { '<leader>fc', function() Snacks.picker.grep_word { cwd = project_root() } end, desc = 'Grep word under cursor (project root)' },

    -- Git
    { '<leader>gb', function() Snacks.picker.git_branches() end, desc = 'Navigate git branches' },

    -- Zoom (replaces vim-maximizer)
    { '<leader>sm', function() Snacks.zen.zoom() end, desc = 'Maximize/minimize a split' },

    -- Notifications
    { '<leader>un', function() Snacks.notifier.hide() end, desc = 'Dismiss all notifications' },
  },
}
