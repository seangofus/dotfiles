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

-- Force-enable CSI-u (Kitty keyboard protocol + modifyOtherKeys level 2)
-- so <C-j>/<C-k>/<C-i>/<C-m>/<CR> are distinguishable inside tmux.
-- tmux-256color terminfo lacks CSI-u entries, so Neovim's startup handshake
-- doesn't negotiate this; we enable it explicitly. Ghostty supports the
-- Kitty keyboard protocol natively, and tmux 3.5a forwards CSI-u through
-- when extended-keys is on.
local csiu_group = vim.api.nvim_create_augroup('SeangofusCSIu', { clear = true })

vim.api.nvim_create_autocmd('UIEnter', {
  group = csiu_group,
  callback = function()
    -- Kitty keyboard protocol: push disambiguate-escape-codes flag
    io.stdout:write('\27[>1u')
    -- xterm modifyOtherKeys level 2 (fallback if Kitty proto unsupported)
    io.stdout:write('\27[>4;2m')
  end,
})

vim.api.nvim_create_autocmd('VimLeave', {
  group = csiu_group,
  callback = function()
    -- Pop Kitty keyboard flags
    io.stdout:write('\27[<u')
    -- Reset modifyOtherKeys
    io.stdout:write('\27[>4;0m')
  end,
})
