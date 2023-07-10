return {
	'jay-babu/mason-null-ls.nvim',
	after = 'null-ls.nvim',
	config = function()
		require('mason-null-ls').setup {
			handlers = {}
		}
		require('null-ls').setup {}
	end,
}
