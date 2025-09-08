return {
  'neovim/nvim-lspconfig',
  dependencies = { 'saghen/blink.cmp' },

  -- example calling setup directly for each LSP
  config = function()
    local capabilities = vim.lsp.protocol.make_client_capabilities()

    capabilities = vim.tbl_deep_extend('force', capabilities, require('blink.cmp').get_lsp_capabilities({}, false))
    capabilities = vim.tbl_deep_extend('force', capabilities, {
      textDocument = {
        foldingRange = {
          dynamicRegistration = false,
          lineFoldingOnly = true
        }
      }
    })

    local lspconfig = require('lspconfig')
    lspconfig['lua_ls'].setup({ capabilities = capabilities })
  end
}
