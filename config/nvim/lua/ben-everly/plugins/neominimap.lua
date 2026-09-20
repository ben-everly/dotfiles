return {
	"Isrothy/neominimap.nvim",
	version = "v3.x.x",
	lazy = false,
	keys = {
		{ "<leader>mm", "<cmd>Neominimap Toggle<cr>", desc = "Toggle minimap" },
		{ "<leader>mt", "<cmd>Neominimap TabToggle<cr>", desc = "Toggle minimap for tab" },
		{ "<leader>mf", "<cmd>Neominimap ToggleFocus<cr>", desc = "Toggle minimap focus" },
	},
	init = function()
		vim.g.neominimap = {
			auto_enable = false,
			layout = "split",
			split = { direction = "right", minimap_width = 12 },
			-- panels are already covered by the default exclude_buftypes
			exclude_filetypes = {
				"help",
				"bigfile",
				"gitcommit",
				"gitrebase",
				"octo",
				"octo_panel",
			},
		}
	end,
}
