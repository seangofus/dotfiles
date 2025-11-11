return {
  "neovim/nvim-lspconfig",
  config = function()
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    -- Replace this with the servers you want to use
    local servers = { "lua" }

    for _, lsp in ipairs(servers) do
      vim.lsp.config(lsp, {
        capabilities = capabilities,
      })
      vim.lsp.enable(lsp)
    end
  end,
}
