return {
	{
		"folke/lazydev.nvim",
		ft = "lua",
		lazy = true,
		opts = { library = { "~/.dotfiles/config/nvim/lua" } },
	},
	{
		"saghen/blink.cmp",
		optional = true,
		dependencies = { "folke/lazydev.nvim" },
		opts = {
			sources = {
				default = { "lazydev" },
				providers = {
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						score_offset = 100,
					},
				},
			},
		},
	},
}
