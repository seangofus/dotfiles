-- nvim-treesitter `main` branch (full rewrite for Nvim 0.12+).
-- Requirements: tree-sitter-cli >= 0.26.1, a C compiler. Both verified.
--
-- Differences vs. the old `master` branch:
--   * No more `require('nvim-treesitter.configs').setup{}` API.
--   * No lazy-loading: `lazy = false`.
--   * Parsers are installed declaratively via `require('nvim-treesitter').install{}`.
--   * Highlighting/indentation must be enabled with explicit `FileType` autocmds.
return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,
    build = ':TSUpdate',
    dependencies = {
      { 'windwp/nvim-ts-autotag', opts = {} },
    },
    config = function()
      local ts = require 'nvim-treesitter'
      ts.setup {
        install_dir = vim.fn.stdpath 'data' .. '/site',
      }

      -- Parsers we use. `install` is async and a no-op if already installed.
      local parsers = {
        'json',
        'javascript',
        'typescript',
        'tsx',
        'yaml',
        'html',
        'css',
        'prisma',
        'markdown',
        'markdown_inline',
        'svelte',
        'graphql',
        'bash',
        'lua',
        'vim',
        'vimdoc',
        'dockerfile',
        'gitignore',
        'query',
        'go',
        'gomod',
        'gosum',
        'gowork',
        'terraform',
        'hcl',
        'php',
        'regex',
        'sql',
        'diff',
      }
      ts.install(parsers)

      -- Enable treesitter highlighting + indentation per filetype.
      -- Map parser names back to their actual filetypes (some differ).
      local fts = vim.iter(parsers):map(function(p)
        return vim.treesitter.language.get_filetypes(p)
      end):flatten():totable()

      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('seangofus.treesitter', { clear = true }),
        pattern = fts,
        callback = function(args)
          -- Highlighting (provided by Nvim core).
          pcall(vim.treesitter.start, args.buf)
          -- Indentation (still experimental on main branch; opt-in per buffer).
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })

      -- Incremental selection (was previously configured via .configs.setup).
      -- The new branch does not provide this out of the box, so we use the
      -- built-in treesitter node selection (added in Nvim 0.10+):
      --   v_an / v_in    select outer/inner node (incremental)
      --   v_]n / v_[n    move to next/prev sibling
      -- Mapping <C-space> to start incremental selection at cursor:
      vim.keymap.set('n', '<C-space>', function()
        -- Enter visual mode and select the smallest node at cursor; then `an`/`in`
        -- can be used to expand. This mirrors the old `init_selection` behavior.
        vim.cmd.normal { 'van', bang = true }
      end, { desc = 'Treesitter: start incremental selection' })
    end,
  },
}
