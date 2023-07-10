return {
	'williamboman/mason-lspconfig.nvim',
	after = 'mason.nvim',
	config = function()
		require('mason-lspconfig').setup {}
	end,
}
