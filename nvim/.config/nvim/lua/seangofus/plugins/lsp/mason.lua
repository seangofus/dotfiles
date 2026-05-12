return {
  'williamboman/mason.nvim',
  dependencies = {
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
  },
  config = function()
    local mason = require 'mason'
    local mason_lspconfig = require 'mason-lspconfig'
    local mason_tool_installer = require 'mason-tool-installer'

    mason.setup {
      ui = {
        border = 'rounded',
        icons = {
          package_installed = '✓',
          package_pending = '➜',
          package_uninstalled = '✗',
        },
      },
    }

    mason_lspconfig.setup {
      ensure_installed = {
        'ts_ls',
        'html',
        'cssls',
        'tailwindcss',
        'svelte',
        'lua_ls',
        'graphql',
        'emmet_ls',
        'prismals',
        'pyright',
        'intelephense',
        'gopls',
        'marksman',
      },
      automatic_installation = true,
    }

    mason_tool_installer.setup {
      ensure_installed = {
        'prettierd',
        'stylua',
        'black',
        'tflint',
        'golangci-lint',
        'gofumpt',
        'goimports',
        'golines',
        'js-debug-adapter',
        'php-debug-adapter',
      },
    }
  end,
}
