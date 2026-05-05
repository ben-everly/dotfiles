return {
	"stevearc/aerial.nvim",
	opts = {
		layout = { default_direction = "right", min_width = 30 },
		attach_mode = "global",
		show_guides = true,
	},
	keys = {
		{ "<C-b>", "<cmd>AerialToggle!<cr>", desc = "Toggle outline" },
	},
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
}
