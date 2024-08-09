---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require("custom.highlights")

M.ui = {
  theme = "oxocarbon",
  theme_toggle = { "one_light", "oxocarbon" },

  hl_override = highlights.override,
  hl_add = highlights.add,

  statusline = {
    theme = "vscode_colored", -- default/vscode/vscode_colored/minimal
    -- default/round/block/arrow separators work only for default statusline theme
    -- round and block will work for minimal theme only
    separator_style = "block",
    overriden_modules = nil,
  },

  tabufline = {
    enabled = true,
    lazyload = true,
    order = { "treeOffset", "buffers", "tabs", "btns" },
  },
}

M.plugins = "custom.plugins"

-- check core.mappings for table structure
M.mappings = require("custom.mappings")

-- Re-enable some disabled plugins
-- based on <https://github.com/NvChad/NvChad/issues/1949>
M.lazy_nvim = {
	performance = {
		rtp = {
			disabled_plugins = vim.tbl_filter(function(name)
				return string.sub(name, 1, 5) ~= "netrw"
			end, require("plugins.configs.lazy_nvim").performance.rtp.disabled_plugins),
		},
	},
}

return M
