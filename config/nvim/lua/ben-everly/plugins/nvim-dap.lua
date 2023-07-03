return {
	'mfussenegger/nvim-dap',
	config = function()
		vim.keymap.set('n', '<leader>d<cr>', require 'dap'.continue)
		vim.keymap.set('n', '<leader>dq', function()
			require 'dap'.terminate()
			require 'dap'.close()
		end)
		vim.keymap.set('n', '<leader>dr', require 'dap'.restart)
		vim.keymap.set('n', '<leader>db', require 'dap'.toggle_breakpoint)
		vim.keymap.set('n', '<leader>dj', require 'dap'.step_over)
		vim.keymap.set('n', '<leader>dl', require 'dap'.step_into)
		vim.keymap.set('n', '<leader>dh', require 'dap'.step_out)

		local dap = require 'dap'
		dap.adapters.php = {
			type = 'executable',
			command = 'node',
			args = { '/home/beneverly/.local/lib/php-debug-client/out/phpDebug.js' }
		}

		dap.configurations.php = {
			{
				type = 'php',
				request = 'launch',
				name = 'Listen for Xdebug',
				port = 9000,
				log = true,
				pathMappings = {
					['/var/www/app/'] = '${workspaceFolder}'
				}
			}
		}
	end
}
