return {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'saghen/blink.cmp',
    { 'antosha417/nvim-lsp-file-operations', config = true },
  },
  config = function()
    local keymap = vim.keymap

    local on_attach = function(_, bufnr)
      keymap.set('n', 'gR', function()
        Snacks.picker.lsp_references()
      end, { desc = 'Show LSP references', buffer = bufnr })
      keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = 'Go to declaration', buffer = bufnr })
      keymap.set('n', 'gd', function()
        Snacks.picker.lsp_definitions()
      end, { desc = 'Show LSP definitions', buffer = bufnr })
      keymap.set('n', 'gi', function()
        Snacks.picker.lsp_implementations()
      end, { desc = 'Show LSP implementations', buffer = bufnr })
      keymap.set('n', 'gt', function()
        Snacks.picker.lsp_type_definitions()
      end, { desc = 'Show LSP type definitions', buffer = bufnr })
      keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, { desc = 'See available code actions', buffer = bufnr })
      keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'Smart rename', buffer = bufnr })
      keymap.set('n', '<leader>D', function()
        Snacks.picker.diagnostics_buffer()
      end, { desc = 'Show buffer diagnostics', buffer = bufnr })
      keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Show line diagnostics', buffer = bufnr })
      keymap.set('n', '[d', function()
        vim.diagnostic.jump { count = -1, float = true }
      end, { desc = 'Go to previous diagnostic', buffer = bufnr })
      keymap.set('n', ']d', function()
        vim.diagnostic.jump { count = 1, float = true }
      end, { desc = 'Go to next diagnostic', buffer = bufnr })
      keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Show documentation', buffer = bufnr })
      keymap.set('n', '<leader>rs', ':LspRestart<CR>', { desc = 'Restart LSP', buffer = bufnr })
    end

    local capabilities = require('blink.cmp').get_lsp_capabilities()

    -- Diagnostic config (replaces deprecated vim.fn.sign_define)
    vim.diagnostic.config {
      underline = true,
      virtual_text = false,
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = ' ',
          [vim.diagnostic.severity.WARN] = ' ',
          [vim.diagnostic.severity.HINT] = '󰠠 ',
          [vim.diagnostic.severity.INFO] = ' ',
        },
      },
      update_in_insert = true,
      float = { border = 'rounded' },
    }

    -- LSP servers
    local servers = {
      html = {},
      ts_ls = {},
      cssls = {},
      tailwindcss = {
        filetypes = {
          'html',
          'css',
          'scss',
          'sass',
          'javascript',
          'javascriptreact',
          'typescript',
          'typescriptreact',
          'svelte',
          'astro',
          'vue',
        },
        root_dir = vim.fs.dirname(vim.fs.find({
          'tailwind.config.js',
          'tailwind.config.cjs',
          'package.json',
          '.git',
        }, { upward = true })[1] or vim.uv.cwd()),
        settings = {
          tailwindCSS = {
            validate = true,
            includeLanguages = {
              elixir = 'html-eex',
              eelixir = 'html-eex',
              heex = 'html-eex',
            },
            classAttributes = { 'class', 'className', 'class:list', 'classList', 'ngClass' },
            lint = {
              cssConflict = 'warning',
              invalidApply = 'error',
              invalidConfigPath = 'error',
              invalidScreen = 'error',
              invalidTailwindDirective = 'error',
              invalidVariant = 'error',
              recommendedVariantOrder = 'warning',
            },
          },
        },
      },
      svelte = {},
      prismals = {},
      graphql = {
        filetypes = { 'graphql', 'gql', 'svelte', 'typescriptreact', 'javascriptreact' },
      },
      emmet_ls = {
        filetypes = { 'html', 'typescriptreact', 'javascriptreact', 'css', 'sass', 'scss', 'less', 'svelte' },
      },
      pyright = {},
      intelephense = {},
      twiggy_language_server = {},
      gopls = {},
      terraformls = {},
      lua_ls = {
        settings = {
          Lua = {
            diagnostics = { globals = { 'vim' } },
            workspace = {
              library = {
                [vim.fn.expand '$VIMRUNTIME/lua'] = true,
                [vim.fn.stdpath 'config' .. '/lua'] = true,
              },
            },
          },
        },
      },
      eslint = {
        settings = {
          runtime = 'node',
          validate = 'on',
          packageManager = 'npm',
          workingDirectories = { { mode = 'auto' } },
        },
        root_markers = { '.eslintrc.js', '.eslintrc.cjs', '.eslintrc.json', '.eslintrc', 'package.json' },
      },
    }

    -- Setup all servers
    for name, config in pairs(servers) do
      config.capabilities = capabilities
      config.on_attach = config.on_attach or on_attach
      vim.lsp.config(name, config)
      vim.lsp.enable(name)
    end

    -- LspInfo border
    vim.lsp.config('*', { ui = { border = 'rounded' } })
  end,
}
