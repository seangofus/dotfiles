-- lazydev.nvim: Lua dev experience tuned for editing your nvim config.
-- Auto-injects type-checked completions for `vim.*`, plugin globals (Snacks,
-- MiniNotify, etc.), and any required modules. Replaces the manual workspace
-- library entries that used to live in lspconfig.lua's `lua_ls` settings.
return {
  'folke/lazydev.nvim',
  ft = 'lua',
  opts = {
    library = {
      -- Load `Snacks` types when the buffer requires snacks (or any of its modules).
      { path = 'snacks.nvim/types', words = { 'Snacks' } },
      -- LazyVim-style: types for vim.uv (libuv) — improves cwd/hrtime/etc. completion.
      { path = 'luvit-meta/library', words = { 'vim%.uv' } },
    },
  },
}
