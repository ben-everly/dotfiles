return {
	"hrsh7th/nvim-cmp",
	optional = true,
	dependencies = { "hrsh7th/cmp-buffer" },
	opts = function(_, opts)
		table.insert(opts.sources, { name = "buffer", group_index = 9 })
	end,
}
