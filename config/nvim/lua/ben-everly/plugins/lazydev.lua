return {
	{
		'folke/lazydev.nvim',
		ft = 'lua',
		lazy = true,
		opts = {
			library = {
				"~/.dotfiles/config/nvim/lua",
			},
		},
	},
	{
		'hrsh7th/nvim-cmp',
		optional = true,
		dependencies = {
			'folke/lazydev.nvim',
		},
		opts = function (_, opts)
			if not opts.sources then opts.sources = {} end
			table.insert(opts.sources, { name = 'lazydev', group_index = 0 })
		end,
	},
}
