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

    -- ── Replaces alpha-nvim ─────────────────────────────────────────────
    dashboard = {
      enabled = true,
      preset = {
        header = table.concat({
          '             ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗',
          '             ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║',
          '             ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║',
          '             ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║',
          '             ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║',
          '             ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝',
        }, '\n'),
        keys = {
          { icon = ' ', key = 'f', desc = 'Find File', action = function() Snacks.picker.files { cwd = project_root() } end },
          { icon = ' ', key = 'n', desc = 'New File', action = ':ene | startinsert' },
          { icon = ' ', key = 'g', desc = 'Find Text', action = function() Snacks.picker.grep { cwd = project_root() } end },
          { icon = ' ', key = 'r', desc = 'Recent Files', action = function() Snacks.picker.recent() end },
          { icon = ' ', key = 'c', desc = 'Config', action = function() Snacks.picker.files { cwd = vim.fn.stdpath 'config' } end },
          { icon = '󰒲 ', key = 'l', desc = 'Lazy', action = ':Lazy' },
          { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
        },
      },
      sections = {
        { section = 'header' },
        { section = 'keys', gap = 1, padding = 1 },
        { section = 'startup' },
      },
    },

    -- ── Replaces plugin/floaterminal.lua ────────────────────────────────
    terminal = {
      win = {
        position = 'float',
        border = 'rounded',
        width = 0.8,
        height = 0.8,
      },
    },

    -- ── Replaces whisk.nvim ─────────────────────────────────────────────
    scroll = {
      animate = {
        duration = { step = 15, total = 250 },
        easing = 'outQuad',
      },
    },

    -- Bonus: open file at cursor in browser (covers another git-blame.nvim use case).
    gitbrowse = { enabled = true },
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
    { '<leader>gB', function() Snacks.gitbrowse() end, desc = 'Open file in git browser' },

    -- Zoom (replaces vim-maximizer)
    { '<leader>sm', function() Snacks.zen.zoom() end, desc = 'Maximize/minimize a split' },

    -- Notifications
    { '<leader>un', function() Snacks.notifier.hide() end, desc = 'Dismiss all notifications' },

    -- Floating terminal (replaces plugin/floaterminal.lua)
    { '<space>tt', function() Snacks.terminal() end, mode = { 'n', 't' }, desc = 'Toggle floating terminal' },
  },
}
