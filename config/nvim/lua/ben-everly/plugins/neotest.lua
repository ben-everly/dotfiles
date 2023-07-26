return {
	'nvim-neotest/neotest',
	dependencies = {
		'nvim-lua/plenary.nvim',
		'antoinemadec/FixCursorHold.nvim',
		'theutz/neotest-pest',
	},
	config = function()
		require 'neotest'.setup({
			adapters = {
				require 'neotest-pest' ({
					pest_cmd = function()
						return { 'sail', 'pest' }
					end
				}),
			},
			projects = {
				['/home/beneverly/Development/github.com/oberd/overt/'] = {
					require 'neotest-pest' ({
						pest_cmd = function()
							vim.cmd.wa()
							return { 'sail', 'pest' }
						end,
						path_maps = {
							['/home/beneverly/Development/github.com/oberd/overt/'] = '',
						}
					}),
				}
			}
		})

		--vim.keymap.set('n', '<C-Enter>', function() print(fix_path(vim.fn.expand('%'))) end)
		vim.keymap.set('n', '<C-Enter>', function() require 'neotest'.run.run(vim.fn.expand('%')) end)
		--To test a directory run lua require'neotest'.run.run("path/to/directory")
		--To test the full test suite run lua require'neotest'.run.run({ suite = true })
	end
}
