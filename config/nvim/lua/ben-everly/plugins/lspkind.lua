return {
	"hrsh7th/nvim-cmp",
	optional = true,
	dependencies = { "onsails/lspkind.nvim" },
	opts = function(_, opts)
		opts.formatting = {
			format = require("lspkind").cmp_format({
				mode = "symbol",
				symbol_map = {
					Text = " ",
					Method = " ",
					Function = " ",
					Constructor = " ",
					Field = " ",
					Variable = " ",
					Class = " ",
					Interface = " ",
					Module = " ",
					Property = " ",
					Unit = " ",
					Value = " ",
					Enum = " ",
					Keyword = " ",
					Snippet = " ",
					Color = " ",
					File = " ",
					Reference = " ",
					Folder = " ",
					EnumMember = " ",
					Constant = " ",
					Struct = " ",
					Event = " ",
					Operator = " ",
					TypeParameter = " ",
				},
			}),
		}
	end,
}
