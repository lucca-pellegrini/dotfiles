local opt = vim.opt
local api = vim.api
local g = vim.g
-- local config = require("core.utils").load_config()

-------------------------------------- options ------------------------------------------
-- Indenting
opt.expandtab = false
opt.shiftwidth = 8
opt.smartindent = true
opt.tabstop = 8
opt.softtabstop = 8

-- Scrolling
opt.scrolloff = 10
opt.sidescrolloff = 10
opt.mousescroll = "ver:1"

-- Practical enhancements
opt.virtualedit = "block"      -- Allow virtual editing on blockwise visual
opt.backspace = "start,indent" -- Backspacing rules
opt.textwidth = 79             -- By default, lines must be less than 80 columns wide
opt.path = opt.path + "**"     -- Search all subdirectories recursively with :find
opt.mousemoveevent = true      -- Enable mouse move events

-- Visual enhancements
opt.pumblend = 10 -- Pseudo-transparency for the popup menu
opt.winblend = 10 -- Pseudo-transparency for floating windows
opt.relativenumber = true -- Set line numbers to relative by default
opt.wrap = false -- Disable text wapping by default
opt.fillchars = opt.fillchars + "diff:╱" -- Set custom virtual characters
opt.colorcolumn = { 80 } -- Highlight the 80th column
api.nvim_set_hl(0, "ColorColumn", { ctermbg = "black" }) -- Set color to black
opt.title = true -- Set window title to 'titlestring'
opt.titlestring = "%{ObsessionStatus()}%m%r%q NeoVim (%n) %f %y %03l:%02c --%p%%--" -- Window title
opt.titlelen = 50 -- Maximum length of window title
opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"
g.man_hardwrap = 0 -- Enable dynamic width for :Man pages (may break tables)

-- Enable code folding with Treesitter
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldenable = false
opt.fillchars = opt.fillchars + "fold:┄" + "foldopen:┌" + "foldclose:┼"

-- Load custom options for Neovide
if g.neovide then
  require("custom.configs.neovide")
end

-------------------------------------- autocmds ------------------------------------------
-- Highlight selection on yank
api.nvim_create_autocmd({ "TextYankPost" }, {
  callback = function()
    vim.highlight.on_yank({
      higroup = "IncSearch",
      timeout = 250,
    })
  end,
})

-- Filetype rules
api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "tex", "java" },
  callback = function()
    vim.bo.expandtab = false
    vim.bo.tabstop = 4
    vim.bo.softtabstop = 4
    vim.bo.shiftwidth = 4
  end,
})
api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "python", "lilypond", "cs", "sql" },
  callback = function()
    vim.bo.expandtab = true
    vim.bo.tabstop = 4
    vim.bo.softtabstop = 4
    vim.bo.shiftwidth = 4
  end,
})
api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "html", "css", "typescript", "lisp", "lua", "javascriptreact", "dart" },
  callback = function()
    vim.bo.expandtab = true
    vim.bo.tabstop = 2
    vim.bo.softtabstop = 2
    vim.bo.shiftwidth = 2
  end,
})
api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "haskell" }, -- Haskell rules from <http://dmwit.com/tabs/>
  callback = function()
    vim.bo.expandtab = false
    vim.bo.copyindent = true
    vim.bo.preserveindent = true
    vim.bo.tabstop = 8
    vim.bo.softtabstop = 0
    vim.bo.shiftwidth = 8
  end,
})

----------------------------------- Providers -------------------------------------------
-- Python
g.python3_host_prog = '/usr/bin/python'
g.loaded_python3_provider = 1

-- Node.js
g.node_host_prog = os.getenv("XDG_DATA_HOME")
  .. "/nvm/versions/node/"
  .. io.popen("node -v"):read("*a"):gsub("\n", "")
  .. "/bin/neovim-node-host"
g.loaded_node_provider = 1

-------------------------------------- LSP ----------------------------------------------
-- Auto-show diagnostics on hover
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  virtual_text = true,
  underline = true,
  signs = true,
})

-- If we hold the cursor for one second on a line, show diagnostics
--[[ api.nvim_create_autocmd({"CursorHold"}, {
	callback = function()
    vim.defer_fn(
      vim.diagnostic.open_float,
      750
    )
  end
}) ]]

--[[ api.nvim_create_autocmd({"CursorHoldI"}, {
	callback = function()
    vim.lsp.buf.signature_help()
  end
}) ]]
--[[ autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()
autocmd CursorHoldI * silent! lua vim.lsp.buf.signature_help() ]]
