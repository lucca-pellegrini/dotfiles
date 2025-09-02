local null_ls = require("null-ls")

local b = null_ls.builtins

local sources = {

  -- webdev stuff
  b.formatting.prettier.with({ filetypes = { "html", "markdown", "css" } }), -- so prettier works only on these filetypes

  -- Lua
  b.formatting.stylua,

  -- C
  b.formatting.clang_format.with({
    -- extra_args = { -- Use my custom config by default
    -- 	"--style=file:" .. os.getenv("XDG_CONFIG_HOME") .. "/NvChad/configs/clang-format",
    -- },
  }),

  -- Go
  b.formatting.gofumpt,
  b.formatting.goimports_reviser.with({
    extra_args = {
      "-rm-unused",
      "-set-alias",
      "-use-cache",
    },
  }),
  b.formatting.golines.with({
    extra_args = {
      "--max-len=" .. 80,
      "--tab-len=" .. 2, -- This is our current setting in init.lua
    },
  }),

  -- Python
  b.formatting.isort,
  b.formatting.pyink,

  -- SQL
  b.formatting.sqruff,
  b.formatting.pg_format,

  -- GitHub actions
  b.diagnostics.actionlint,
}

null_ls.setup({
  debug = true,
  sources = sources,
})
