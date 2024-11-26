return {
	{
		'petertriho/cmp-git',
		dependencies = {
			'hrsh7th/nvim-cmp',
			'nvim-lua/plenary.nvim',
		},
		main = 'cmp_git',
	},
	{
		'hrsh7th/nvim-cmp',
		optional = true,
		opts = function (_, opts)
			table.insert(opts.sources, { name = 'git' })
		end,
	},
}
