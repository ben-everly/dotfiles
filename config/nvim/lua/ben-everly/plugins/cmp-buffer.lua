return {
	'hrsh7th/nvim-cmp',
	optional = true,
	dependencies = {
		'hrsh7th/cmp-buffer',
	},
	opts = function(_, opts)
		if not opts.sources then opts.sources = {} end
		table.insert(opts.sources, { name = 'buffer', group_index = 9 })
	end,
}
