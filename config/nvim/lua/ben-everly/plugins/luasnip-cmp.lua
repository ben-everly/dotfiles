return {
	'hrsh7th/nvim-cmp',
	optional = true,
	dependencies = {
		'saadparwaiz1/cmp_luasnip',
	},
	opts = function (_, opts)
		if not opts.sources then opts.sources = {} end
		table.insert(opts.sources, { name = 'luasnip', group_index = 1 })
		opts.snippet = {
			expand = function(args)
				require('luasnip').lsp_expand(args.body)
			end,
		}
	end,
}
