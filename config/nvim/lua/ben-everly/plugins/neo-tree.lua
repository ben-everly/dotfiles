return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	lazy = false,
	keys = {
		{ "<leader>n", "<cmd>Neotree toggle<cr>", desc = "Files: toggle tree" },
		{ "<leader>N", "<cmd>Neotree reveal<cr>", desc = "Files: reveal in tree" },
	},
	opts = {
		-- "nofile" covers sidebar/tool buffers (Neogit, aerial, Trouble, ...).
		open_files_do_not_replace_types = { "terminal", "Trouble", "qf", "edgy", "nofile" },
		filesystem = {
			-- oil.nvim handles directory buffers instead.
			hijack_netrw_behavior = "disabled",
			bind_to_cwd = false,
			filtered_items = {
				hide_dotfiles = false,
				never_show = { "node_modules", "vendor", ".git" },
			},
			window = {
				mappings = {
					["~"] = {
						function(state)
							require("neo-tree.sources.filesystem").navigate(state, vim.uv.cwd())
						end,
						desc = "navigate to cwd",
					},
				},
				fuzzy_finder_mappings = {
					["<C-j>"] = "move_cursor_down",
					["<C-k>"] = "move_cursor_up",
				},
			},
		},
	},
}
