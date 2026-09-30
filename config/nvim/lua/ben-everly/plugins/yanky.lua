return {
	"gbprod/yanky.nvim",
	lazy = false,
	opts = {},
	keys = {
		{ "p", "<Plug>(YankyPutAfter)", mode = { "n", "x" }, desc = "Yank: put after" },
		{ "P", "<Plug>(YankyPutBefore)", mode = { "n", "x" }, desc = "Yank: put before" },
		{ "gp", "<Plug>(YankyGPutAfter)", mode = { "n", "x" }, desc = "Yank: gput after" },
		{
			"gP",
			"<Plug>(YankyGPutBefore)",
			mode = { "n", "x" },
			desc = "Yank: gput before",
		},
		{
			"<c-n>",
			"<Plug>(YankyCycleForward)",
			mode = { "n", "x" },
			desc = "Yank: cycle forward",
		},
		{
			"<c-p>",
			"<Plug>(YankyCycleBackward)",
			mode = { "n", "x" },
			desc = "Yank: cycle backward",
		},
		{
			"<leader>fy",
			function()
				local telescope = require("telescope")
				telescope.load_extension("yank_history")
				telescope.extensions.yank_history.yank_history()
			end,
			mode = { "n", "x" },
			desc = "Find: yank history",
		},
	},
}
