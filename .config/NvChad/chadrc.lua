---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require("custom.highlights")

M.ui = {
  theme = "pastelbeans",
  theme_toggle = { "one_light", "pastelbeans" },

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
    overriden_modules = function(modules)
      table.remove(modules, 1)
    end,
  },

  nvdash = {
    load_on_startup = true,

    header = {
      [==[      ____________       ]==],
      [==[     /\  ________ \      ]==],
      [==[    /  \ \______/\ \     ]==],
      [==[   / /\ \ \  / /\ \ \    ]==],
      [==[  / / /\ \ \/ / /\ \ \   ]==],
      [==[ / / /__\_\/ / /__\_\ \  ]==],
      [==[/ /_/_______/ /________\ ]==],
      [==[\ \ \______ \ \______  / ]==],
      [==[ \ \ \  / /\ \ \  / / /  ]==],
      [==[  \ \ \/ / /\ \ \/ / /   ]==],
      [==[   \ \/ / /__\_\/ / /    ]==],
      [==[    \  / /______\/ /     ]==],
      [==[     \/___________/      ]==],
    },
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
        return not vim.tbl_contains(
          { "netrw", "netrwPlugin", "netrwSettings", "netrwFileHandlers", "tohtml", "2html_plugin" },
          name
        )
      end, require("plugins.configs.lazy_nvim").performance.rtp.disabled_plugins),
    },
  },
}

return M
