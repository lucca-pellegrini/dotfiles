local base = require("plugins.configs.lspconfig")
local on_attach = base.on_attach
local capabilities = base.capabilities

local lspconfig = require("lspconfig")
local util = require("lspconfig.util")

-- if you just want default config for the servers then put them in a table
local servers = { "html", "cssls", "tsserver", "texlab", "ltex" }

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
