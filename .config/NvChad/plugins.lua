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

  -- Undo tree visualization and navigation
  {
    "debugloop/telescope-undo.nvim",
    dependencies = {
      {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
      },
    },
    keys = { { "<leader>u", "<cmd>Telescope undo<cr>", desc = "undo history" } },
    -- opts = {
    --   -- don't use `defaults = { }` here, do this in the main telescope spec
    --   extensions = {
    --     undo = {
    --       -- telescope-undo.nvim config, see below
    --     },
    --     -- no other extensions here, they can have their own spec too
    --   },
    -- },
    config = function(_, opts)
      -- Calling telescope's setup from multiple specs does not hurt, it will happily merge the
      -- configs for us. We won't use data, as everything is in it's own namespace (telescope
      -- defaults, as well as each extension).
      require("telescope").setup(opts)
      require("telescope").load_extension("undo")
    end,
  },

  -- Generative AI integration
  {
    "NickvanDyke/opencode.nvim",
    dependencies = {
      -- Recommended for a better prompt input, and required to use opencode.nvim's embedded terminal. Otherwise optional.
      { "folke/snacks.nvim", opts = { input = { enabled = true } } },
    },
    ---@type opencode.Opts
    opts = {
      -- Your configuration, if any
    },
    keys = {
      -- Recommended keymaps
      { '<leader>oa', function() require('opencode').ask('@cursor: ') end,                          desc = 'Ask opencode',                 mode = 'n', },
      { '<leader>oa', function() require('opencode').ask('@selection: ') end,                       desc = 'Ask opencode about selection', mode = 'v', },
      { '<leader>ot', function() require('opencode').toggle() end,                                  desc = 'Toggle embedded opencode', },
      { '<leader>on', function() require('opencode').command('session_new') end,                    desc = 'New session', },
      { '<leader>oy', function() require('opencode').command('messages_copy') end,                  desc = 'Copy last message', },
      { '<S-C-u>',    function() require('opencode').command('messages_half_page_up') end,          desc = 'Scroll messages up', },
      { '<S-C-d>',    function() require('opencode').command('messages_half_page_down') end,        desc = 'Scroll messages down', },
      { '<leader>op', function() require('opencode').select_prompt() end,                           desc = 'Select prompt',                mode = { 'n', 'v', }, },
      -- Example: keymap for custom prompt
      { '<leader>oe', function() require('opencode').prompt("Explain @cursor and its context") end, desc = "Explain code near cursor", },
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
      require("trouble").setup({
        modes = {
          symbols = {
            win = { position = "left" },
          },
        },
      })
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
    tag = "v12.0.2",
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
        init_options = {
          documentSymbol = {
            dynamicRegistration = false,
            hierarchicalDocumentSymbolSupport = true,
            labelSupport = true,

            symbolKind = {
              valueSet = {
                1,
                2,
                3,
                4,
                5,
                6,
                7,
                8,
                9,
                10,
                11,
                12,
                13,
                14,
                15,
                16,
                17,
                18,
                19,
                20,
                21,
                22,
                23,
                24,
                25,
                26,
                27,
                28,
                29,
                30,
                31,
              },
              tagSupport = {
                valueSet = {},
              },
            },
          },
        },

        -- NOTE: custom java settings
        -- https://github.com/ray-x/lsp_signature.nvim/issues/97
        -- all options:
        -- https://github.com/mfussenegger/nvim-jdtls
        -- https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
        single_file_support = true,
        redhat = { telemetry = { enabled = false } },
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

  -- Language-specific plugins

  -- SonarLint support
  {
    "https://gitlab.com/schrieveslaach/sonarlint.nvim",
    commit = "cd7276e9d741492e2de149c98c4f406c2984640c",
    ft = {
      "c",
      "cobol",
      "cpp",
      "cs",
      "css",
      "go",
      "html",
      "java",
      "js",
      "kotlin",
      "php",
      "python",
      "ruby",
      "ts",
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
          "c",
          "cobol",
          "cpp",
          "cs",
          "css",
          "go",
          "html",
          "java",
          "js",
          "kotlin",
          "php",
          "python",
          "ruby",
          "ts",
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

  -- Markdown preview support
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },

  -- Organizer plugin
  {
    "nvim-neorg/neorg",
    lazy = true,
    cmd = { "Neorg" },
    config = function()
      require("neorg").setup({
        load = {
          ["core.defaults"] = {},
          ["core.export"] = {},
          ["core.presenter"] = {
            config = {
              zen_mode = "truezen",
            },
          },
          ["core.concealer"] = {
            config = {
              icon_preset = "varied",
            },
          },
          ["core.completion"] = {
            config = {
              engine = "nvim-cmp",
            },
          },
          ["core.integrations.nvim-cmp"] = {},
        },
      })
    end,
  },

  -- Distraction-free mode plugin
  {
    "pocco81/true-zen.nvim",
    lazy = true,
    cmd = { "TZAtaraxis", "TZMinimalist", "TZNarrow", "TZFocus" },
  },

  -- Flutter support
  {
    "nvim-flutter/flutter-tools.nvim",
    ft = "dart",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("flutter-tools").setup({
        widget_guides = { enabled = true },
        dev_tools = {
          autostart = false,         -- autostart devtools server if not detected
          auto_open_browser = false, -- Automatically opens devtools in the browser
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
    submodules = false,
    ft = "help",

    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
  },

  -- Override plugin definition options

  {
    "neovim/nvim-lspconfig",
    tag = "v1.8.0",
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
    branch = "v1.x",
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
}

return plugins
