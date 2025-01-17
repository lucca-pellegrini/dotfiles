---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require("custom.highlights")

M.ui = {
  theme = "vscode_dark",
  theme_toggle = { "one_light", "vscode_dark" },

  hl_override = highlights.override,
  hl_add = highlights.add,

  statusline = {
    theme = "vscode_colored", -- default/vscode/vscode_colored/minimal
    -- default/round/block/arrow separators work only for default statusline theme
    -- round and block will work for minimal theme only
    separator_style = "block",

    overriden_modules = function(modules)
      local custom_modules = require("custom.configs.statusline")

      -- Iterate over the custom modules
      for name, func in pairs(custom_modules) do
        -- Replace the corresponding function in the modules table
        for i, module in ipairs(modules) do
          if module:find(name) then
            modules[i] = func()
          end
        end
      end
    end,
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
