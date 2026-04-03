return {
	{
		"petertriho/cmp-git",
		lazy = true,
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
	},
	{
		"hrsh7th/nvim-cmp",
		optional = true,
		dependencies = { "petertriho/cmp-git" },
		opts = function(_, opts)
			table.insert(opts.sources, { name = "git", group_index = 1 })
		end,
	},
}
