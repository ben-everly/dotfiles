return {
	{
		'folke/lazydev.nvim',
		ft = 'lua',
		opts = {
			library = {
				"~/.dotfiles/config/nvim/lua",
			},
		},
	},
	{
		'hrsh7th/nvim-cmp',
		optional = true,
		opts = function (_, opts)
			table.insert(opts.sources, { name = 'lazydev', group_index = 0 })
		end,
	},
}
