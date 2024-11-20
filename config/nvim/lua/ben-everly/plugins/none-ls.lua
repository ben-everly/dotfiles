return {
	'nvimtools/none-ls.nvim',
	dependencies = {
		'jay-babu/mason-null-ls.nvim',
	},
	config = function()
		require'null-ls'.setup {
			border = 'single',
		}
	end
}
