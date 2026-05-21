return {
	{
		"ricardoramirezr/blade-nav.nvim",
		dependencies = { "saghen/blink.cmp" },
		ft = { "blade", "php" },
		opts = { close_tag_on_complete = true },
	},
	{
		"saghen/blink.cmp",
		optional = true,
		opts = {
			sources = {
				default = { "blade-nav" },
				providers = {
					["blade-nav"] = {
						name = "blade-nav",
						module = "blade-nav.integrations.blink",
						score_offset = 100,
						min_keyword_length = 0,
						opts = { close_tag_on_complete = true },
					},
				},
			},
		},
	},
}
