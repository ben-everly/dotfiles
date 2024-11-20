return {
	'jay-babu/mason-null-ls.nvim',
	dependencies = {
		'williambowman/mason.nvim',
	},
	config = function()
		require('mason-null-ls').setup {
			handlers = {}
		}
	end,
}
