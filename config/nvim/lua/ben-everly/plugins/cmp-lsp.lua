return {
	"hrsh7th/nvim-cmp",
	optional = true,
	dependencies = { "hrsh7th/cmp-nvim-lsp" },
	opts = function(_, opts)
		if not opts.sources then
			opts.sources = {}
		end
		table.insert(opts.sources, { name = "nvim_lsp", group_index = 1 })
	end,
}
