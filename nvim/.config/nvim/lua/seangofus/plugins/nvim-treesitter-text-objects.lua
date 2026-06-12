-- nvim-treesitter-textobjects `main` branch (rewrite for Nvim 0.12+).
--
-- All previous keymaps preserved verbatim. The selection/swap/move logic now
-- lives in three separate modules:
--   * nvim-treesitter-textobjects.select
--   * nvim-treesitter-textobjects.swap
--   * nvim-treesitter-textobjects.move
-- and `repeatable_move` for ;/, repeat behavior.
return {
  'nvim-treesitter/nvim-treesitter-textobjects',
  branch = 'main',
  lazy = true,
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  config = function()
    require('nvim-treesitter-textobjects').setup {
      select = {
        -- Mirrors the previous `lookahead = true` behavior.
        lookahead = true,
        include_surrounding_whitespace = false,
      },
      move = {
        set_jumps = true,
      },
    }

    local select = require 'nvim-treesitter-textobjects.select'
    local swap = require 'nvim-treesitter-textobjects.swap'
    local move = require 'nvim-treesitter-textobjects.move'
    local ts_repeat_move = require 'nvim-treesitter-textobjects.repeatable_move'

    -- ── Select ─────────────────────────────────────────────────────────────
    -- Helper: bind both `x` and `o` modes to a textobject capture.
    local function map_select(lhs, capture, query_group, desc)
      vim.keymap.set({ 'x', 'o' }, lhs, function()
        select.select_textobject(capture, query_group or 'textobjects')
      end, { desc = desc })
    end

    map_select('a=', '@assignment.outer', nil, 'Select outer part of an assignment')
    map_select('i=', '@assignment.inner', nil, 'Select inner part of an assignment')
    map_select('l=', '@assignment.lhs', nil, 'Select left hand side of an assignment')
    map_select('r=', '@assignment.rhs', nil, 'Select right hand side of an assignment')

    -- Custom captures defined in after/queries/ecma/textobjects.scm
    map_select('a:', '@property.outer', nil, 'Select outer part of an object property')
    map_select('i:', '@property.inner', nil, 'Select inner part of an object property')
    map_select('l:', '@property.lhs', nil, 'Select left part of an object property')
    map_select('r:', '@property.rhs', nil, 'Select right part of an object property')

    map_select('aa', '@parameter.outer', nil, 'Select outer part of a parameter/argument')
    map_select('ia', '@parameter.inner', nil, 'Select inner part of a parameter/argument')

    map_select('ai', '@conditional.outer', nil, 'Select outer part of a conditional')
    map_select('ii', '@conditional.inner', nil, 'Select inner part of a conditional')

    map_select('al', '@loop.outer', nil, 'Select outer part of a loop')
    map_select('il', '@loop.inner', nil, 'Select inner part of a loop')

    map_select('af', '@call.outer', nil, 'Select outer part of a function call')
    map_select('if', '@call.inner', nil, 'Select inner part of a function call')

    map_select('am', '@function.outer', nil, 'Select outer part of a method/function definition')
    map_select('im', '@function.inner', nil, 'Select inner part of a method/function definition')

    map_select('ac', '@class.outer', nil, 'Select outer part of a class')
    map_select('ic', '@class.inner', nil, 'Select inner part of a class')

    -- ── Swap ───────────────────────────────────────────────────────────────
    vim.keymap.set('n', '<leader>na', function() swap.swap_next '@parameter.inner' end, { desc = 'Swap parameter with next' })
    vim.keymap.set('n', '<leader>n:', function() swap.swap_next '@property.outer' end, { desc = 'Swap property with next' })
    vim.keymap.set('n', '<leader>nm', function() swap.swap_next '@function.outer' end, { desc = 'Swap function with next' })
    vim.keymap.set('n', '<leader>pa', function() swap.swap_previous '@parameter.inner' end, { desc = 'Swap parameter with prev' })
    vim.keymap.set('n', '<leader>p:', function() swap.swap_previous '@property.outer' end, { desc = 'Swap property with prev' })
    vim.keymap.set('n', '<leader>pm', function() swap.swap_previous '@function.outer' end, { desc = 'Swap function with prev' })

    -- ── Move ───────────────────────────────────────────────────────────────
    local function map_move(lhs, fn, capture, query_group, desc)
      vim.keymap.set({ 'n', 'x', 'o' }, lhs, function()
        fn(capture, query_group or 'textobjects')
      end, { desc = desc })
    end

    map_move(']f', move.goto_next_start, '@call.outer', nil, 'Next function call start')
    map_move(']m', move.goto_next_start, '@function.outer', nil, 'Next method/function def start')
    map_move(']c', move.goto_next_start, '@class.outer', nil, 'Next class start')
    map_move(']i', move.goto_next_start, '@conditional.outer', nil, 'Next conditional start')
    map_move(']l', move.goto_next_start, '@loop.outer', nil, 'Next loop start')
    map_move(']s', move.goto_next_start, '@local.scope', 'locals', 'Next scope')
    map_move(']z', move.goto_next_start, '@fold', 'folds', 'Next fold')

    map_move(']F', move.goto_next_end, '@call.outer', nil, 'Next function call end')
    map_move(']M', move.goto_next_end, '@function.outer', nil, 'Next method/function def end')
    map_move(']C', move.goto_next_end, '@class.outer', nil, 'Next class end')
    map_move(']I', move.goto_next_end, '@conditional.outer', nil, 'Next conditional end')
    map_move(']L', move.goto_next_end, '@loop.outer', nil, 'Next loop end')

    map_move('[f', move.goto_previous_start, '@call.outer', nil, 'Prev function call start')
    map_move('[m', move.goto_previous_start, '@function.outer', nil, 'Prev method/function def start')
    map_move('[c', move.goto_previous_start, '@class.outer', nil, 'Prev class start')
    map_move('[i', move.goto_previous_start, '@conditional.outer', nil, 'Prev conditional start')
    map_move('[l', move.goto_previous_start, '@loop.outer', nil, 'Prev loop start')

    map_move('[F', move.goto_previous_end, '@call.outer', nil, 'Prev function call end')
    map_move('[M', move.goto_previous_end, '@function.outer', nil, 'Prev method/function def end')
    map_move('[C', move.goto_previous_end, '@class.outer', nil, 'Prev class end')
    map_move('[I', move.goto_previous_end, '@conditional.outer', nil, 'Prev conditional end')
    map_move('[L', move.goto_previous_end, '@loop.outer', nil, 'Prev loop end')

    -- ── Repeatable movement ────────────────────────────────────────────────
    -- Vim-way: ; repeats in the last direction, , repeats in the opposite.
    vim.keymap.set({ 'n', 'x', 'o' }, ';', ts_repeat_move.repeat_last_move)
    vim.keymap.set({ 'n', 'x', 'o' }, ',', ts_repeat_move.repeat_last_move_opposite)

    -- Make built-in f/F/t/T also repeatable with ; and , (note: new branch
    -- exposes these as `_expr` versions that need `expr = true`).
    vim.keymap.set({ 'n', 'x', 'o' }, 'f', ts_repeat_move.builtin_f_expr, { expr = true })
    vim.keymap.set({ 'n', 'x', 'o' }, 'F', ts_repeat_move.builtin_F_expr, { expr = true })
    vim.keymap.set({ 'n', 'x', 'o' }, 't', ts_repeat_move.builtin_t_expr, { expr = true })
    vim.keymap.set({ 'n', 'x', 'o' }, 'T', ts_repeat_move.builtin_T_expr, { expr = true })
  end,
}
