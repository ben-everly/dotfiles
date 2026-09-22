return {
	"stevearc/oil.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	-- Loaded eagerly so oil can take over directory buffers (e.g. `nvim .`).
	lazy = false,
	---@module "oil"
	---@type oil.SetupOpts
	opts = {
		default_file_explorer = true,
		delete_to_trash = true,
		view_options = {
			show_hidden = true,
		},
	},
	keys = {
		{ "-", "<cmd>Oil<cr>", desc = "Open parent directory" },
		{ "<leader>-", "<cmd>Oil --float<cr>", desc = "Open parent directory (float)" },
	},
}
