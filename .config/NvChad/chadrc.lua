---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require("custom.highlights")

M.ui = {
	theme = "one_light",
	theme_toggle = { "one_light", "one_light" },

	hl_override = highlights.override,
	hl_add = highlights.add,
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
