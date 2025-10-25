---@type MappingsTable
local M = {}

M.general = {
  n = {
    ["<leader>mk"] = { ":make<CR>", "Run GNU Make" },
    ["<leader>mt"] = { ":!ctags -R .<CR>", "Make ctags" },

    -- Fix NvChad overriding vim-tmux-navigator bindings
    ["<C-h>"] = { "<cmd> TmuxNavigateLeft<CR>", "Window left" },
    ["<C-j>"] = { "<cmd> TmuxNavigateDown<CR>", "Window down" },
    ["<C-k>"] = { "<cmd> TmuxNavigateUp<CR>", "Window up" },
    ["<C-l>"] = { "<cmd> TmuxNavigateRight<CR>", "Window right" },

    -- Fix NvChad overriding jumplist navigation
    ["<C-i>"] = { "<C-i>", "Jumplist forward" },

    -- Binding to show LSP Diagnostics
    ["<leader>e"] = {
      function()
        vim.diagnostic.open_float()
      end,
      "Show diagnostic",
    },

    -- The above overrides the keybind below, so we change it
    ["<leader><C-e>"] = { "<cmd> NvimTreeFocus <CR>", "Focus nvimtree" },
  },
}

-- Bindings for the Lspsaga plugin
M.lspsaga = {
  plugin = true,
  n = {
    ["<leader>ca"] = {
      "<cmd> Lspsaga code_action <CR>",
      "List code actions",
    },
    ["<leader>to"] = {
      "<cmd> Lspsaga outline <CR>",
      "Toggle document outline",
    },
    ["<leader>dn"] = {
      "<cmd> Lspsaga diagnostic_jump_next <CR>",
      "Jump to next diagnostic",
    },
    ["<leader>dp"] = {
      "<cmd> Lspsaga diagnostic_jump_prev <CR>",
      "Jump to previous diagnostic",
    },
  },
}

-- Key bindings for the Debug Adapter Protocol client
M.dap = {
  plugin = true,
  n = {
    ["<leader>db"] = {
      "<cmd> DapToggleBreakpoint <CR>",
      "Add breakpoint at line",
    },
    ["<leader>dr"] = {
      "<cmd> DapContinue <CR>",
      "Start or continue debugger",
    },
    ["<leader>dus"] = {
      function()
        local widgets = require("dap.ui.widgets")
        local sidebar = widgets.sidebar(widgets.scopes)
        sidebar.open()
      end,
      "Open debugging sidebar",
    },
    ["<leader>dlp"] = {
      function()
        require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
      end,
      "Add log point at line",
    },
    ["<leader>dcp"] = {
      function()
        require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end,
      "Add conditional breakpoint at line",
    },
    ["<F5>"] = {
      "<cmd> DapContinue <CR>",
      "Start or continue debugger",
    },
    ["<F10>"] = {
      "<cmd> DapStepOver <CR>",
      "Step Over",
    },
    ["<F11>"] = {
      "<cmd> DapStepInto <CR>",
      "Step Into",
    },
    ["<F12>"] = {
      "<cmd> DapStepOut <CR>",
      "Step Out",
    },
  },
}

-- DAP bindings for Go
M.dap_go = {
  plugin = true,
  n = {
    ["<leader>dgt"] = { -- Debug nearest go test to cursor
      function()
        require("dap-go").debug_test()
      end,
      "Debug go test",
    },
    ["<leader>dgl"] = { -- Rerun the last test
      function()
        require("dap-go").debug_last()
      end,
      "Debug last go test",
    },
  },
}

-- Bindings for the gopher.nvim plugin
M.gopher = {
  plugin = true,
  n = {
    ["<leader>gsj"] = {
      "<cmd> GoTagAdd json <CR>",
      "Add json struct tags",
    },
    ["<leader>gsy"] = {
      "<cmd> GoTagAdd yaml <CR>",
      "Add yaml struct tags",
    },
  },
}

-- Bindings for Trouble
M.trouble = {
  plugin = true,
  n = {
    ["<leader>tl"] = {
      "<cmd>Trouble diagnostics toggle<cr>",
      "Toggle diagnostics list",
    },
    ["<leader>tb"] = {
      "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
      "Toggle diagnostics list for this buffer",
    },
    ["<leader>ts"] = {
      "<cmd>Trouble symbols toggle focus=false<cr>",
      "Toggle symbols list",
    },
    --[[ ["<leader>cl"] = {
      "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
      "LSP Definitions / references / ... (Trouble)",
    },
    ["<leader>xL"] = {
      "<cmd>Trouble loclist toggle<cr>",
      "Location List (Trouble)",
    }, ]]
    ["<leader>tq"] = {
      "<cmd>Trouble qflist toggle<cr>",
      "Toggle quickfix list",
    },
  },
}

-- Bindings for the Vimtex plugin
M.vimtex = {
  plugin = true,
  n = {
    ["<leader>tc"] = {
      "<cmd> VimtexTocToggle <CR>",
      "Toggle table of contents",
    },
  },
}

-- more keybinds!

return M
