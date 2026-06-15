-- neotest: unified test runner with per-language adapters.
-- Adapters loaded for the languages in this codebase ecosystem: JS/TS (jest +
-- vitest) and Go. Add more adapters as needed (pytest, rspec, etc.).
return {
  'nvim-neotest/neotest',
  cmd = { 'Neotest' },
  keys = {
    -- Note: prefix is capital T to avoid colliding with the `<leader>t*` tab
    -- keymaps in core/keymaps.lua (to/tx/txa/tn/tp/tf).
    { '<leader>Tn', function() require('neotest').run.run() end, desc = 'Run nearest test' },
    { '<leader>Tf', function() require('neotest').run.run(vim.fn.expand '%') end, desc = 'Run tests in file' },
    { '<leader>Tl', function() require('neotest').run.run_last() end, desc = 'Run last test' },
    { '<leader>Td', function() require('neotest').run.run { strategy = 'dap' } end, desc = 'Debug nearest test' },
    { '<leader>Ts', function() require('neotest').summary.toggle() end, desc = 'Toggle test summary' },
    { '<leader>To', function() require('neotest').output.open { enter = true, auto_close = true } end, desc = 'Show test output' },
    { '<leader>TO', function() require('neotest').output_panel.toggle() end, desc = 'Toggle output panel' },
    { '<leader>TS', function() require('neotest').run.stop() end, desc = 'Stop test run' },
    { '[t', function() require('neotest').jump.prev { status = 'failed' } end, desc = 'Jump to previous failed test' },
    { ']t', function() require('neotest').jump.next { status = 'failed' } end, desc = 'Jump to next failed test' },
  },
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',
    -- Adapters
    'nvim-neotest/neotest-jest',
    'marilari88/neotest-vitest',
    'fredrikaverpil/neotest-golang',
  },
  config = function()
    require('neotest').setup {
      adapters = {
        require 'neotest-jest' {
          jestCommand = 'npx jest --',
          env = { CI = true },
          cwd = function() return vim.fn.getcwd() end,
        },
        require 'neotest-vitest',
        require 'neotest-golang' {
          go_test_args = { '-v', '-race', '-count=1' },
        },
      },
      status = { virtual_text = true },
      output = { open_on_run = false },
      quickfix = {
        open = function()
          -- Use snacks for results display when available, else default.
          if package.loaded['snacks'] and Snacks and Snacks.picker then
            Snacks.picker.qflist()
          else
            vim.cmd 'copen'
          end
        end,
      },
    }
  end,
}
