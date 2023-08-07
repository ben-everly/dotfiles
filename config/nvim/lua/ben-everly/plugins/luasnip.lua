return {
	'L3MON4D3/LuaSnip',
	version = 'v1.*',
	config = function()
		vim.keymap.set('n', 'gs', require('luasnip.loaders').edit_snippet_files)
		local ls = require('luasnip')
		vim.keymap.set({"s"}, "<Tab>", function() ls.jump( 1) end, {silent = true})
		vim.keymap.set({"s"}, "<S-Tab>", function() ls.jump(-1) end, {silent = true})

		vim.keymap.set({"i", "s"}, "<C-E>", function()
			if ls.choice_active() then
				ls.change_choice(1)
			end
		end, {silent = true})
	end,
}
