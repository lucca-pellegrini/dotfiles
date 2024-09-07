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
opt.virtualedit = "block" -- Allow virtual editing on blockwise visual
opt.backspace = "indent"  -- Only allow backspacing over autoindent

-- Visual enhancements
opt.pumblend = 10 -- Pseudo-transparency for the popup menu
opt.winblend = 10 -- Pseudo-transparency for floating windows
opt.relativenumber = true -- Set line numbers to relative by default
opt.wrap = false -- Disable text wapping by default
opt.fillchars = opt.fillchars + "diff:╱" -- Set custom virtual characters
opt.colorcolumn = { 80 } -- Highlight the 80th column
api.nvim_set_hl(0, "ColorColumn", { ctermbg = "black" }) -- Set color to black
opt.title = true -- Set window title to 'titlestring'
opt.titlestring = "NeoVim (%n) %f %y %03l:%02c --%p%%-- %m%r%q" -- Window title
opt.titlelen = 50 -- Maximum length of window title

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
  pattern = { "tex" },
  command = "setlocal noet ts=4 sts=4 sw=4", -- Tabs, 4
})
api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "python", "lilypond", "java", "cs" },
  command = "setlocal et ts=4 sts=4 sw=4", -- Spaces, 4
})
api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "html", "css", "typescript", "lisp", "lua", "javascriptreact" },
  command = "setlocal et ts=2 sts=2 sw=2", -- Spaces, 2
})
api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "haskell" }, -- Haskell rules from <http://dmwit.com/tabs/>
  command = "setlocal noet ci pi ts=8 sts=8 sw=8 sts=0",
})

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
