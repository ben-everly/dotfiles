return {
	{ 'hrsh7th/cmp-nvim-lsp' },
	{
		'hrsh7th/nvim-cmp',
		optional = true,
		opts = function(_, opts)
			table.insert(opts.sources, { name = 'nvim_lsp', group_index = 1 })
		end,
	}
}
