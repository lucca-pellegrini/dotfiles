local null_ls = require "null-ls"

local b = null_ls.builtins

local sources = {

  -- webdev stuff
  b.formatting.deno_fmt, -- choosed deno for ts/js files cuz its very fast!
  b.formatting.prettier.with { filetypes = { "html", "markdown", "css" } }, -- so prettier works only on these filetypes

  -- Lua
  b.formatting.stylua,

  -- C
  b.formatting.clang_format.with {
    extra_args = { -- Use my custom config by default
      "--style=file:" .. os.getenv("XDG_CONFIG_HOME") .. "/NvChad/configs/clang-format",
    },
  },
}

null_ls.setup {
  debug = true,
  sources = sources,
}
