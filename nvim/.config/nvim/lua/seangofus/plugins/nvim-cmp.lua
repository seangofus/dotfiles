return {
  'saghen/blink.cmp',
  version = '1.*',
  event = 'VeryLazy',
  dependencies = {
    'rafamadriz/friendly-snippets',
    'zbirenbaum/copilot.lua',
    'giuxtaposition/blink-cmp-copilot',
  },

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = {
      preset = 'none',
      ['<C-k>'] = { 'select_prev', 'fallback' },
      ['<C-j>'] = { 'select_next', 'fallback' },
      ['<C-p>'] = { 'select_prev', 'fallback' },
      ['<C-n>'] = { 'select_next', 'fallback' },
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
      default = { 'lsp', 'path', 'snippets', 'buffer', 'copilot', 'lazydev' },
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
        lazydev = {
          name = 'LazyDev',
          module = 'lazydev.integrations.blink',
          -- Outrank the LSP source so lazydev's typed entries win on ties.
          score_offset = 100,
        },
      },
    },

    completion = {
      accept = { auto_brackets = { enabled = true } },
      list = {
        selection = {
          preselect = false,
          auto_insert = false,
        },
      },
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
