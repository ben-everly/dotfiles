return {
	'ben-everly/luasnip-snippets',
	config = function()
		require('luasnip.loaders.from_lua').lazy_load()
	end
}
