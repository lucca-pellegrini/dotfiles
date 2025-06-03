local overrides = require("custom.configs.overrides")

---@type NvPluginSpec[]
local plugins = {

  -- Seamless navigation between tmux panes and vim splits
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<c-h>",  "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>",  "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>",  "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>",  "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  },

  -- Manage delimiter pairs easily
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end,
  },

  -- For case coersion
  {
    "tpope/vim-abolish",
    lazy = false,
  },

  -- For working with dates
  {
    "tpope/vim-speeddating",
    lazy = false,
  },

  -- For automatic session management
  {
    "tpope/vim-obsession",
    lazy = false,
  },

  -- For handling line and column numbers
  {
    "wsdjeg/vim-fetch",
    lazy = false,
  },

  -- Git wrapper
  {
    "tpope/vim-fugitive",
    lazy = false,
  },

  -- Git interface
  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
  },

  -- Generative AI integration
  {
    "yetone/avante.nvim",
    tag = 'v0.0.23',
    event = "VeryLazy",
    lazy = false,
    version = false, -- set this if you want to always pull the latest change
    opts = {
      provider = "openai",
      openai = {
        api_key_name = { "pass", "net/api/openai" },
      },
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "hrsh7th/nvim-cmp",         -- autocompletion for avante commands and mentions
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua",   -- for providers='copilot'
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },

  -- Text alignment
  {
    "godlygeek/tabular",
    lazy = false,
  },

  -- LSP Integration

  -- Diagnostics, callhierarchy, renaming, finder
  {
    "nvimdev/lspsaga.nvim",
    event = "LspAttach",
    config = function()
      require("lspsaga").setup({
        symbol_in_winbar = {
          enable = false,
        },
        ui = {
          code_action = "",
          virtual_text = false,
        },
        require("core.utils").load_mappings("lspsaga"),
        -- require("custom.configs.lspsaga")
      })
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
  },

  -- Custom diagnostics loclist
  {
    "folke/trouble.nvim",
    lazy = true,
    event = "LspAttach",
    cmd = "Trouble",
    config = function()
      require("trouble").setup()
      require("core.utils").load_mappings("trouble")
    end,
  },

  -- Custom icon provider
  {
    "echasnovski/mini.nvim",
    lazy = false,
    version = false,
    config = function()
      -- require("mini.align").setup() -- Disabled temorarily because I need `ga`
      -- require("mini.animate").setup()
      -- require("mini.base16").setup()
      -- require("mini.basics").setup()
      require("mini.bracketed").setup()
      -- require("mini.bufremove").setup()
      -- require("mini.clue").setup()
      -- require("mini.colors").setup()
      -- require("mini.comment").setup()
      -- require("mini.completion").setup()
      require("mini.cursorword").setup()
      -- require("mini.deps").setup()
      -- require("mini.diff").setup()
      -- require("mini.doc").setup()
      -- require("mini.extra").setup()
      -- require("mini.files").setup()
      -- require("mini.fuzzy").setup()
      -- require("mini.git").setup()
      -- require("mini.hipatterns").setup()
      -- require("mini.hues").setup()
      require("mini.icons").setup()
      require("mini.indentscope").setup({
        options = {
          indent_at_cursor = false,
        },
        symbol = "│",
      })
      -- require("mini.jump").setup() -- Disabled because it breaks `,`
      -- require("mini.jump2d").setup()
      -- require("mini.map").setup()
      -- require("mini.misc").setup()
      require("mini.move").setup()
      -- require("mini.notify").setup()
      -- require("mini.operators").setup()
      -- require("mini.pairs").setup()
      -- require("mini.pick").setup()
      -- require("mini.sessions").setup()
      require("mini.splitjoin").setup()
      -- require("mini.starter").setup()
      -- require("mini.statusline").setup()
      -- require("mini.surround").setup()
      -- require("mini.tabline").setup()
      -- require("mini.test").setup()
      require("mini.trailspace").setup()
      -- require("mini.visits").setup()
    end,
  },

  -- Breadcrumbs navigation
  {
    "Bekaboo/dropbar.nvim",
    tag = 'v12.0.2',
    lazy = false,
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
    },
  },

  -- Debugger integration

  -- Debug Adapter Protocol client
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "nvim-neotest/nvim-nio",
    },
    init = function()
      require("core.utils").load_mappings("dap")
      require("custom.configs.dap")
    end,
  },

  -- CodeLLDB (C/C++ debugger) integration
  {
    "jay-babu/mason-nvim-dap.nvim",
    ft = "c",
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
    },
    config = function()
      require("mason-nvim-dap").setup()
    end,
    options = {
      handlers = {},
    },
  },
  {
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    dependencies = "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
    end,
  },

  -- Delve (Go debugger) integration
  {
    "leoluz/nvim-dap-go",
    ft = "go",
    dependencies = "mfussenegger/nvim-dap",
    config = function(_, opts)
      require("dap-go").setup(opts)
      require("core.utils").load_mappings("dap_go")
    end,
  },

  -- Java debugger and integration
  {
    "nvim-java/nvim-java",
    lazy = false,
    dependencies = {
      "nvim-java/lua-async-await",
      "nvim-java/nvim-java-core",
      "nvim-java/nvim-java-dap",
      "nvim-java/nvim-java-refactor",
      "nvim-java/nvim-java-test",
      "MunifTanjim/nui.nvim",
      "neovim/nvim-lspconfig",
      "mfussenegger/nvim-dap",
      {
        "williamboman/mason.nvim",
        opts = {
          registries = {
            "github:nvim-java/mason-registry",
            "github:mason-org/mason-registry",
          },
        },
      },
    },
    config = function()
      require("java").setup({
        jdk = {
          auto_install = false,
          version = "23.0.2",
        },
        jdtls = {
          version = "v1.44.0",
        },
      })
      require("lspconfig").jdtls.setup({
        on_attach = require("plugins.configs.lspconfig").on_attach,
        capabilities = require("plugins.configs.lspconfig").capabilities,
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
    end,
  },

  --[[ {
    "mfussenegger/nvim-jdtls",
    ft = "java",
    event = "LspAttach",
  }, ]]

  -- Language-specific plugins

  -- SonarLint support
  {
    "https://gitlab.com/schrieveslaach/sonarlint.nvim",
    commit = "cd7276e9d741492e2de149c98c4f406c2984640c",
    ft = {
      "js",
      "ts",
      "css",
      "html",
      "python",
      "php",
      "go",
      "ruby",
      "kotlin",
      "cobol",
      "c",
      "cs",
      "python",
      "cpp",
      "java",
    },
    config = function()
      require("sonarlint").setup({
        server = {
          cmd = {
            "sonarlint-language-server",
            -- Ensure that sonarlint-language-server uses stdio channel
            "-stdio",
            "-analyzers",
            -- paths to the analyzers you need, using those for python and java in this example
            vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarpython.jar"),
            vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarcfamily.jar"),
            vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarjava.jar"),
          },
        },
        filetypes = {
          "js",
          "ts",
          "css",
          "html",
          "python",
          "php",
          "go",
          "ruby",
          "kotlin",
          "cobol",
          "c",
          "cs",
          "python",
          "cpp",
          "java",
        },
      })
    end,
  },

  -- Go tooling support
  {
    "olexsmir/gopher.nvim",
    ft = "go",
    config = function(_, opts)
      require("gopher").setup(opts)
      require("core.utils").load_mappings("gopher")
    end,
    build = function()
      vim.cmd([[silent! GoInstallDeps]]) -- Install dependencies
    end,
  },

  -- LaTeX plugins

  {
    "lervag/vimtex",
    lazy = true,
    ft = { "latex", "tex" },
    config = function()
      vim.g.vimtex_view_method = "zathura"
      vim.g.vimtex_compiler_method = "tectonic"
      require("core.utils").load_mappings("vimtex")
    end,
  },
  --[[ {
    "vigoux/ltex-ls.nvim",
    event = "LspAttach",
    ft = { "markdown", "tex" },
    config = function()
      require("ltex-ls").setup({
        use_spellfile = true,
        filetypes = { "latex", "tex", "bib", "markdown", "gitcommit", "text" },
      })
    end,
    dependencies = {
      "neovim/nvim-lspconfig",
    },
  }, ]]
  {
    "barreiroleo/ltex_extra.nvim",
    event = "LspAttach",
    ft = { "latex", "tex", "bib", "markdown", "gitcommit", "text" },
    -- config = function()
    --   require("ltex_extra").setup({
    --     load_langs = { "en-US", "en-GB" },
    --     init_check = true,
    --     path = "", -- project root or current working directory
    --     log_level = "none",
    --     --[[ server_opts = {
    --       -- capabilities = your_capabilities,
    --       on_attach = function(client, bufnr)
    --         -- your on_attach process
    --       end,
    --       -- settings = {
    --       --   ltex = { your settings }
    --       -- }
    --     }, ]]
    --   })
    -- end,
    dependencies = {
      "neovim/nvim-lspconfig",
    },
  },

  -- Flutter support
  {
    "nvim-flutter/flutter-tools.nvim",
    ft = "dart",
    config = function()
      require("flutter-tools").setup({
        debugger = {
          enabled = true,
        },
        dev_log = {
          enabled = true,
        },
        dev_tools = {
          autostart = true,
        },
        lsp = {
          color = {
            enabled = true,
          },
        },
      })
    end,
  },

  -- SQL support
  {
    "Xemptuous/sqlua.nvim",
    cmd = "SQLua",
    config = function()
      require("sqlua").setup()
    end,
  },

  -- Pkl language support
  {
    "apple/pkl-neovim",
    event = "BufReadPre *.pkl",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    build = function()
      vim.cmd("TSInstall! pkl")
    end,
  },

  -- Additional vimdoc features
  {
    "OXY2DEV/helpview.nvim",
    ft = "help",

    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
  },

  -- Override plugin definition options

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- format & linting
      {
        "nvimtools/none-ls.nvim",
        config = function()
          require("custom.configs.null-ls")
        end,
      },
    },
    config = function()
      require("plugins.configs.lspconfig")
      require("custom.configs.lspconfig")
    end, -- Override to setup mason-lspconfig
  },

  -- override plugin configs
  {
    "williamboman/mason.nvim",
    opts = overrides.mason,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  -- Install a plugin
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },

  -- To make a plugin not be loaded
  -- {
  --   "NvChad/nvim-colorizer.lua",
  --   enabled = false
  -- },

  -- All NvChad plugins are lazy-loaded by default
  -- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
  -- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example
  -- {
  --   "mg979/vim-visual-multi",
  --   lazy = false,
  -- }
}

return plugins
