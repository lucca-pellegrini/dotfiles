local M = {}

M.treesitter = {
  ensure_installed = {
    "c",
    "css",
    "go",
    "html",
    "java",
    "javascript",
    "lua",
    "markdown",
    "markdown_inline",
    "php",
    "rust",
    "tsx",
    "typescript",
    "vim",
  },
  indent = {
    enable = true,
    -- disable = {
    --   "python"
    -- },
  },
}

M.mason = {
  ensure_installed = {
    -- lua stuff
    "lua-language-server",
    "stylua",

    -- web dev stuff
    "css-lsp",
    "html-lsp",
    "typescript-language-server",
    "deno",
    "prettier",
    "phpactor",
    "laravel_ls",

    -- c/cpp stuff
    "clang-format",
    "clangd",
    "codelldb",

    -- Go
    "gopls",
    "gofumpt",
    -- "goimports_reviser",
    "golines",
    "delve",

    -- Java
    "sonarlint-language-server",
  },
}

-- git support in nvimtree
M.nvimtree = {
  git = {
    enable = true,
  },

  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
    },
  },
}

return M
