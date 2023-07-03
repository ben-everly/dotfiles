return function()
	require 'neotest'.setup({
		adapters = {
			require 'neotest-pest' ({
				pest_cmd = function()
					return 'sail pest'
				end
			}),
		}
	})

	vim.keymap.set('n', '<C-Enter>', function() require 'neotest'.run.run(vim.fn.expand('%')) end)
	--To test a directory run lua require'neotest'.run.run("path/to/directory")
	--To test the full test suite run lua require'neotest'.run.run({ suite = true })
end
