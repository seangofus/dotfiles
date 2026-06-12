return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'nvim-neotest/nvim-nio',
    -- build debugger from source
    {
      'microsoft/vscode-js-debug',
      version = '1.x',
      build = 'npm i && npm run compile dapDebugServer && mv dist out',
    },
    {
      'xdebug/vscode-php-debug',
      version = '1.x',
      build = 'npm i && npm run build',
    },
  },
  keys = {
    -- normal mode is default
    {
      '<leader>db',
      function()
        require('dap').toggle_breakpoint()
      end,
      desc = 'Set Breakpoint',
    },
    {
      '<leader>dc',
      function()
        require('dap').continue()
      end,
      desc = 'Debug Continue',
    },
    {
      '<leader>dn',
      function()
        require('dap').step_over()
      end,
      desc = 'Step Over',
    },
    {
      '<leader>di',
      function()
        require('dap').step_into()
      end,
      desc = 'Step Into',
    },
    {
      '<leader>do',
      function()
        require('dap').step_out()
      end,
      desc = 'Step Out',
    },
    {
      '<leader>dC',
      function()
        require('dap').clear_breakpoints()
      end,
      desc = 'Clear Breakpoints',
    },
    {
      '<leader>ds',
      function()
        require('dap').disconnect()
      end,
      desc = 'Terminate Debug Session',
    },
  },
  config = function()
    local dap = require 'dap'

    -- vscode-js-debug adapters (registered directly, no wrapper plugin needed).
    -- Each adapter type maps to the same dapDebugServer.js entry point built from
    -- microsoft/vscode-js-debug (see the build step above).
    local js_debug_path = vim.fn.stdpath 'data' .. '/lazy/vscode-js-debug/out/src/dapDebugServer.js'
    for _, adapter in ipairs { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' } do
      dap.adapters[adapter] = {
        type = 'server',
        host = 'localhost',
        port = '${port}',
        executable = {
          command = 'node',
          args = { js_debug_path, '${port}' },
        },
      }
    end

    for _, language in ipairs { 'typescript', 'javascript', 'svelte', 'typescriptreact' } do
      dap.configurations[language] = {
        {
          type = 'pwa-node',
          request = 'launch',
          name = '🚀 Launch file',
          program = '${file}',
          cwd = '${workspaceFolder}',
        },
        {
          type = 'pwa-node',
          request = 'attach',
          name = '🖖 Attach',
          processId = require('dap.utils').pick_process,
          cwd = '${workspaceFolder}/src',
          sourceMaps = true,
        },
        {
          type = 'pwa-chrome',
          request = 'launch',
          name = '💻 Start Chrome with "localhost"',
          url = 'http://localhost:3000',
          webRoot = '${workspaceFolder}',
          userDataDir = '${workspaceFolder}/.vscode/vscode-chrome-debug-userdatadir',
        },
        {
          name = '🪬 Next.js: debug server-side',
          type = 'pwa-node',
          request = 'attach',
          cwd = '${workspaceFolder}',
          port = 9232,
          skipFiles = { '<node_internals>/**', 'node_modules/**' },
          sourceMaps = true,
        },
      }
    end

    dap.adapters.php = {
      type = 'executable',
      command = 'node',
      args = { vim.fn.stdpath 'data' .. '/lazy/vscode-php-debug/out/phpDebug.js' },
    }

    dap.configurations.php = {
      {
        type = 'php',
        request = 'launch',
        name = '🐞 Listen for Xdebug',
        port = 9000,
        pathMappings = {
          ['/var/www'] = '${workspaceFolder}',
        },
      },
    }

    local dapui = require 'dapui'
    dapui.setup {
      icons = { expanded = '▾', collapsed = '▸' },
      expand_lines = vim.fn.has 'nvim-0.7',
      layouts = {
        {
          elements = {
            'scopes',
          },
          size = 0.3,
          position = 'right',
        },
        {
          elements = {
            'repl',
            'breakpoints',
          },
          size = 0.3,
          position = 'bottom',
        },
      },
      floating = {
        max_height = nil,
        max_width = nil,
        border = 'rounded',
        mappings = {
          close = { 'q', '<Esc>' },
        },
      },
      windows = { indent = 1 },
      render = {
        max_type_length = nil,
      },
    }
    dap.listeners.after.event_initialized['dapui_config'] = function()
      dapui.open { reset = true }
    end
    dap.listeners.before.event_terminated['dapui_config'] = function()
      dapui.close {}
    end
    dap.listeners.before.event_exited['dapui_config'] = function()
      dapui.close {}
    end

    vim.keymap.set('n', '<leader>ui', dapui.toggle)
    vim.fn.sign_define('DapBreakpoint', { text = '☠️' })
  end,
}
