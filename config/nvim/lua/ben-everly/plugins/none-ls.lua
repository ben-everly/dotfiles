return {
	'nvimtools/none-ls.nvim',
	config = function()
		require'null-ls'.setup {
			border = 'single',
		}
	end
}
