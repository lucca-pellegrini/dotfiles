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
  },
}

-- more keybinds!

return M
