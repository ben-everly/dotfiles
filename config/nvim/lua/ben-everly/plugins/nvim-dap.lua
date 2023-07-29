return {
	'mfussenegger/nvim-dap',
	config = function()
		local dap = require 'dap'
		vim.keymap.set('n', '<leader>d', function()
			require'libmodal'.mode.enter('DEBUG', {
				enter = function() dap.continue() end,
				q = function() dap.disconnect() end,
				r = function() dap.restart() end,
				b = function() dap.toggle_breakpoint() end,
				j = function() dap.step_over() end,
				l = function() dap.step_into() end,
				h = function() dap.step_out() end,
			})
		end)

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
				port = 9003,
				log = true,
				pathMappings = {
					['/var/www/html/'] = '${workspaceFolder}'
				}
			}
		}
	end
}
