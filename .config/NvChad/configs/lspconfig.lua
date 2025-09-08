local base = require("plugins.configs.lspconfig")
local on_attach = base.on_attach
local capabilities = base.capabilities

local lspconfig = require("lspconfig")
local util = require("lspconfig.util")

-- if you just want default config for the servers then put them in a table
local servers = {
  "ast_grep",
  "cssls",
  "html",
  "laravel_ls",
  "lemminx",
  "phpactor",
  "postgres_lsp",
  "pyright",
  "rust_analyzer",
  "sqlls",
  "texlab",
  "ts_ls",
}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })
end

-- Overrides for clangd
lspconfig.clangd.setup({
  on_attach = function(client, buffer)
    client.server_capabilities.signatureHelpProvider = false
    on_attach(client, buffer)
  end,
  capabilities = capabilities,
})

-- Go
lspconfig.gopls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_dir = util.root_pattern("go.work", "go.mod", ".git"),
  settings = {
    gopls = {
      completeUnimported = true,
      usePlaceholders = true,

      gofumpt = true,
      staticcheck = true,

      analyses = {
        unusedparameters = true,

        nilness = true,
        unusedvariable = true,
        unusedwrite = true,
        useany = true,
      },
    },
  },
})

-- LTeX Language Server
lspconfig.ltex.setup({
  capabilities = capabilities,
  on_attach = function()
    require("ltex_extra").setup({
      load_langs = { "en-US", "en-GB" },
      init_check = true,
      path = "", -- project root or current working directory
      log_level = "none",
    })
  end,
  settings = {
    ltex = {
      language = "auto",
    },
  },
})

-- Bash Language Server
lspconfig.bashls.setup({
  filetypes = { "sh", "bash", "zsh" },
})

-- -- Java Language Server
lspconfig.jdtls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "java" },
  settings = {
    java = {
      configuration = {
        runtimes = {
          {
            name = "JavaSE-23",
            path = "/usr/lib/jvm/java-23-openjdk",
            default = true,
          },
        },
      },
    },
  },
})
