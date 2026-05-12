return {
  'JoosepAlviste/nvim-ts-context-commentstring',
  event = { 'BufReadPre', 'BufNewFile' },
  opts = {
    enable_autocmd = false,
  },
  config = function(_, opts)
    require('ts_context_commentstring').setup(opts)

    -- Wire ts-context-commentstring into native gc/gcc commenting
    local get_option = vim.filetype.get_option
    vim.filetype.get_option = function(filetype, option)
      return option == 'commentstring' and require('ts_context_commentstring.internal').calculate_commentstring()
        or get_option(filetype, option)
    end
  end,
}
