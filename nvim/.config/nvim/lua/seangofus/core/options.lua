vim.g.nvim_listen_address = os.getenv 'NVIM'
local opt = vim.opt -- for conciseness

-- line numbers
opt.relativenumber = true -- show relative line numbers
opt.number = true -- shows absolute line number on cursor line (when relative number is on)

-- tabs & indentation
opt.tabstop = 2 -- 2 spaces for tabs (prettier default)
opt.shiftwidth = 2 -- 2 spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one

-- line wrapping
opt.wrap = false -- disable line wrapping

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

-- cursor line
opt.cursorline = true -- highlight the current cursor line

-- appearance
opt.background = 'dark' -- colorschemes that can be light or dark will be made dark
opt.signcolumn = 'yes' -- show sign column so that text doesn't shift

-- backspace
opt.backspace = 'indent,eol,start' -- allow backspace on indent, end of line or insert mode start position

-- clipboard
opt.clipboard:append 'unnamedplus' -- use system clipboard as default register

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- turn off swapfile
opt.swapfile = false

-- ── Nvim 0.12 additions ────────────────────────────────────────────────────

-- Global default border for floating windows. Nvim 0.12 lets us set this once
-- here instead of plumbing `border = 'rounded'` through every plugin's window
-- config (lspconfig.ui, mason ui, oil.float, dapui.floating, etc.).
opt.winborder = 'rounded'

-- Render the completion popup with a rounded border to match.
opt.pumborder = 'rounded'

-- Cap the popup-menu width so completion items with very long signatures don't
-- explode the layout.
opt.pummaxwidth = 80

-- Add `popup` to completeopt so LSP completionItem/resolve previews appear
-- alongside the popup menu when supported by the server.
opt.completeopt:append 'popup'
