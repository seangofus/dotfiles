-- render-markdown.nvim: pretty in-buffer rendering for markdown / mdx files.
-- Renders headings, code-block backgrounds, bullets, checkboxes, tables, etc.
-- as virtual text — your raw file is unchanged.
return {
  'MeanderingProgrammer/render-markdown.nvim',
  ft = { 'markdown', 'mdx' },
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  },
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {
    file_types = { 'markdown', 'mdx' },
    -- Anti-conceal: when the cursor is on a rendered line, show the raw
    -- markdown so you can still edit easily.
    anti_conceal = { enabled = true },
    code = {
      sign = false,
      width = 'block',
      right_pad = 1,
    },
    heading = {
      sign = false,
      icons = { '◉ ', '○ ', '✸ ', '✿ ', '❀ ', '➤ ' },
    },
  },
}
