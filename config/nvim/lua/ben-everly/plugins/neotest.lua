return {
	'nvim-neotest/neotest',
	dependencies = {
		"nvim-neotest/nvim-nio",
		'nvim-lua/plenary.nvim',
		'antoinemadec/FixCursorHold.nvim',
		'V13Axel/neotest-pest',
	},
	config = function()
		require 'neotest'.setup({
			adapters = {
				require 'neotest-pest' ({
					parallel = 10
				}),
			},
		})

		vim.keymap.set('n', '<leader>tt', function() require 'neotest'.run.run() end)
		vim.keymap.set('n', '<leader>tf', function() require 'neotest'.run.run(vim.fn.expand('%')) end)
		vim.keymap.set('n', '<leader>ts', function() require 'neotest'.run.run({ suite = true }) end)
		vim.keymap.set('n', '<leader>td', function() require 'neotest'.run.run({ strategy = 'dap' }) end)
		vim.keymap.set('n', '<leader>to', function() require 'neotest'.output.open({ enter = true }) end)
	end
}
