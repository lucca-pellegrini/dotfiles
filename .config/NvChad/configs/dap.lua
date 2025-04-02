local dap = require("dap")
local mr = require("mason-registry")

-- Set icons and colors
vim.fn.sign_define('DapBreakpoint', { text='', texthl='DiagnosticSignError', numhl='DiagnosticSignError' })
vim.fn.sign_define('DapBreakpointCondition', { text='', texthl='DiagnosticSignInfo', numhl='DiagnosticSignInfo' })
vim.fn.sign_define('DapBreakpointRejected', { text='', texthl='DiagnosticSignWarn', numhl= 'DiagnosticSignWarn' })
vim.fn.sign_define('DapLogPoint', { text='', texthl='DiagnosticSignHint', numhl= 'DiagnosticSignHint' })
vim.fn.sign_define('DapStopped', { text='', texthl='DiagnosticWARNReverse', linehl='DiagnosticWARNReverse', numhl= 'DiagnosticWARNReverse' })

dap.adapters.codelldb = {
  type = "executable",
  name = "codelldb",
  -- path = mr.get_package("codelldb"):get_install_path() .. "/codelldb", --"/extension/adapter/codelldb",
  command = "lldb-vscode",
}

dap.configurations.c = {
  {
    type = "codelldb",
    request = "launch",
    name = "Launch",
    --program = "${input:program}",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    console = "integratedTerminal",
    stopOnEntry = false,
  },
}

--[[ dap.adapters.cpp = {
	type = "executable",
  command = "lldb-vscode",
  --command = mr.get_package("codelldb"):get_install_path() .. "/extension/adapter/codelldb",
	env = {
		LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY = "YES",
	},
	name = "lldb",
}
dap.configurations.cpp = {
	{
		name = "Launch",
		type = "cpp",
		request = "launch",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		cwd = "${workspaceFolder}",
		args = {},
	},
}
dap.configurations.c = dap.configurations.cpp ]]
