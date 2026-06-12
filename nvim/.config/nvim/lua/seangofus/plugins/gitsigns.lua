return {
  'lewis6991/gitsigns.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  opts = {
    -- Inline blame: replaces f-person/git-blame.nvim. The virtual text appears
    -- at end-of-line after a 500ms idle delay (so it doesn't flicker as you move).
    current_line_blame = true,
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = 'eol',
      delay = 500,
      ignore_whitespace = false,
    },
    current_line_blame_formatter = '<author>, <author_time:%R> · <summary>',
  },
}
