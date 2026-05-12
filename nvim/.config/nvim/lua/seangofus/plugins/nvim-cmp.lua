return {
  'saghen/blink.cmp',
  version = '1.*',
  event = 'VeryLazy',
  dependencies = {
    'rafamadriz/friendly-snippets',
    'giuxtaposition/blink-cmp-copilot',
  },

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = {
      preset = 'none',
      ['<C-k>'] = { 'select_prev', 'fallback' },
      ['<C-j>'] = { 'select_next', 'fallback' },
      ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
      ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
      ['<C-Space>'] = { 'show', 'fallback' },
      ['<C-e>'] = { 'cancel', 'fallback' },
      ['<CR>'] = { 'accept', 'fallback' },
    },

    appearance = {
      nerd_font_variant = 'mono',
      kind_icons = {
        Copilot = '',
      },
    },

    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer', 'copilot' },
      per_filetype = {
        sql = { 'dadbod', 'buffer' },
      },
      providers = {
        copilot = {
          name = 'copilot',
          module = 'blink-cmp-copilot',
          score_offset = 100,
          async = true,
        },
        dadbod = {
          name = 'Dadbod',
          module = 'vim_dadbod_completion.blink',
        },
      },
    },

    completion = {
      accept = { auto_brackets = { enabled = true } },
      menu = { border = 'rounded' },
      documentation = {
        auto_show = true,
        window = { border = 'rounded' },
      },
    },

    signature = {
      enabled = true,
      window = { border = 'rounded' },
    },
  },
}
