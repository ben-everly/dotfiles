return {
	"OXY2DEV/markview.nvim",
	lazy = false,
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
	opts = {
		markdown_inline = {
			checkboxes = {
				checked = { scope_hl = false },
				unchecked = { scope_hl = false },
			},
		},
	},
}
