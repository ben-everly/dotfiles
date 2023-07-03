return function()
	local dap, dapui = require 'dap', require 'dapui'
	vim.keymap.set('n', '<M-k>', dapui.eval)
	vim.keymap.set('v', '<M-k>', dapui.eval)
	vim.keymap.set('n', '<leader>dn', require 'dapui'.toggle)
	dapui.setup()
	dap.listeners.after.event_initialized['dapui_config'] = function()
		dapui.open()
	end
	dap.listeners.before.event_terminated['dapui_config'] = function()
		dapui.close()
	end
	dap.listeners.before.event_exited['dapui_config'] = function()
		dapui.close()
	end
end
