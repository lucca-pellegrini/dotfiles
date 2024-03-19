---@type MappingsTable
local M = {}

M.general = {
	n = {
		["<leader>mk"] = { ":make<CR>", "Run GNU Make" },

		-- Fix NvChad overriding vim-tmux-navigator bindings
		["<C-h>"] = { "<cmd> TmuxNavigateLeft<CR>", "Window left" },
		["<C-j>"] = { "<cmd> TmuxNavigateDown<CR>", "Window down" },
		["<C-k>"] = { "<cmd> TmuxNavigateUp<CR>", "Window up" },
		["<C-l>"] = { "<cmd> TmuxNavigateRight<CR>", "Window right" },

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

-- more keybinds!

return M
