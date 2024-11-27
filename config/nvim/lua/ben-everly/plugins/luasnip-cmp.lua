return {
	'hrsh7th/nvim-cmp',
	optional = true,
	dependencies = {
		'saadparwaiz1/cmp_luasnip',
	},
	opts = function (_, opts)
		table.insert(opts.sources, { name = 'luasnip' })
		opts.snippet = {
			expand = function(args)
				require('luasnip').lsp_expand(args.body)
			end,
		}
	end,
}
