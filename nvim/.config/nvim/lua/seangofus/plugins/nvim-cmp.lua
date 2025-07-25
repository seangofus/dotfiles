return {
  'hrsh7th/nvim-cmp',
  event = 'VeryLazy',
  dependencies = {
    'hrsh7th/cmp-buffer', -- source for text in buffer
    'hrsh7th/cmp-path', -- source for file system paths
    'L3MON4D3/LuaSnip', -- snippet engine
    'saadparwaiz1/cmp_luasnip', -- for autocompletion
    'rafamadriz/friendly-snippets', -- useful snippets
    'onsails/lspkind.nvim', -- vs-code like pictograms
  },
  config = function()
    local cmp = require 'cmp'

    local luasnip = require 'luasnip'

    local lspkind = require 'lspkind'

    -- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
    require('luasnip.loaders.from_vscode').lazy_load()

    cmp.setup {
      completion = {
        completeopt = 'menu,menuone,preview,noselect',
      },
      snippet = { -- configure how nvim-cmp interacts with snippet engine
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert {
        ['<C-k>'] = cmp.mapping.select_prev_item(), -- previous suggestion
        ['<C-j>'] = cmp.mapping.select_next_item(), -- next suggestion
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(), -- show completion suggestions
        ['<C-e>'] = cmp.mapping.abort(), -- close completion window
        ['<CR>'] = cmp.mapping.confirm { select = false },
      },
      -- sources for autocompletion
      sources = cmp.config.sources {
        { name = 'nvim_lsp', group_index = 1 },
        { name = 'copilot', group_index = 2 },
        { name = 'buffer' }, -- text within current buffer
        { name = 'path' }, -- file system paths
        { name = 'luasnip' }, -- snippets
      },
      -- configure lspkind for vs-code like pictograms in completion menu
      formatting = {
        expandable_indicator = true,
        format = lspkind.cmp_format {
          symbol_map = { Copilot = '' },
          maxwidth = 50,
          ellipsis_char = '...',
          mode = 'symbol_text',
          before = require('tailwind-tools.cmp').lspkind_format,
        },
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
    }

    cmp.setup.filetype('sql', {
      sources = cmp.config.sources {
        { name = 'vim-dadbod-completion' },
        { name = 'buffer' },
      },
    })
  end,
}
