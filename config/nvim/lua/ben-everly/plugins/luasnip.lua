return {
	'L3MON4D3/LuaSnip',
	version = 'v1.*',
	config = function()
		vim.keymap.set('n', 'gs', require('luasnip.loaders').edit_snippet_files)
	end,
}
