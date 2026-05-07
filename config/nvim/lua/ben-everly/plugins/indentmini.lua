return {
	"nvimdev/indentmini.nvim",

	event = { "BufReadPost", "BufNewFile" },
	opts = {
		char = "▏",
	},
}
