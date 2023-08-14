local base = require("plugins.configs.lspconfig")
local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

-- if you just want default config for the servers then put them in a table
local servers = { "html", "cssls", "tsserver", "texlab", "ltex" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- Overrides for clangd
lspconfig.clangd.setup {
  on_attach = function(client, buffer)
    client.server_capabilities.signatureHelpProvider = false
    on_attach(client, buffer)
  end,
  capabilities = capabilities,
}
