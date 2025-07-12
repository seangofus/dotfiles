return {
  "neovim/nvim-lspconfig",
  config = function()
    local lspconfig = require('lspconfig')
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    -- Replace this with the servers you want to use
    local servers = { "lua" }

    for _, lsp in ipairs(servers) do
      lspconfig[lsp].setup {
        capabilities = capabilities,
      }
    end
  end,
}
