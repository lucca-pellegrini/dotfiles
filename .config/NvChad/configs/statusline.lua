local M = {}

local fn = vim.fn

-- Override to allow tracking of Obsession status (see `:h obsession-status`)
M.cwd = function()
  local icon = fn.ObsessionStatus() == "[$]" and "󰥔" or "󰉖"
  local dir_name = "%#St_cwd# " .. icon .. " " .. fn.fnamemodify(fn.getcwd(), ":t") .. " "
  return (vim.o.columns > 85 and dir_name) or ""
end

return M
