return {
	"gbprod/yanky.nvim",
	lazy = false,
	opts = {},
	keys = {
		{ "p", "<Plug>(YankyPutAfter)", mode = { "n", "x" }, desc = "Put after" },
		{ "P", "<Plug>(YankyPutBefore)", mode = { "n", "x" }, desc = "Put before" },
		{ "gp", "<Plug>(YankyGPutAfter)", mode = { "n", "x" }, desc = "GPut after" },
		{
			"gP",
			"<Plug>(YankyGPutBefore)",
			mode = { "n", "x" },
			desc = "GPut before",
		},
		{
			"<c-n>",
			"<Plug>(YankyCycleForward)",
			mode = { "n", "x" },
			desc = "Cycle forward",
		},
		{
			"<c-p>",
			"<Plug>(YankyCycleBackward)",
			mode = { "n", "x" },
			desc = "Cycle backward",
		},
		{
			"<leader>fy",
			function()
				local telescope = require("telescope")
				telescope.load_extension("yank_history")
				telescope.extensions.yank_history.yank_history()
			end,
			mode = { "n", "x" },
			desc = "Yank history",
		},
	},
}
