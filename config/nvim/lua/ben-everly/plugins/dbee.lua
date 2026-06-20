return {
	"kndndrj/nvim-dbee",
	dependencies = {
		"MunifTanjim/nui.nvim",
	},
	build = function()
		require("dbee").install()
	end,
	cmd = "Dbee",
	keys = {
		{ "<leader>s", function() require("dbee").toggle() end, desc = "Toggle dbee (SQL)" },
	},
	config = function()
		require("dbee").setup({
			sources = {
				require("dbee.sources").FileSource:new(vim.fn.expand("~/.config/dbee/connections.json")),
			},
			-- Default in-UI hotkeys, kept here for reference and easy tweaking.
			-- These mirror dbee's upstream defaults; edit a `key` to rebind.
			drawer = {
				mappings = {
					{ key = "r", mode = "n", action = "refresh" },
					{ key = "<CR>", mode = "n", action = "action_1" }, -- open note / run helper / confirm menu
					{ key = "cw", mode = "n", action = "action_2" }, -- rename note / set connection active
					{ key = "dd", mode = "n", action = "action_3" }, -- delete note / connection
					{ key = "o", mode = "n", action = "toggle" },
					{ key = "<CR>", mode = "n", action = "menu_confirm" },
					{ key = "y", mode = "n", action = "menu_yank" },
					{ key = "<Esc>", mode = "n", action = "menu_close" },
					{ key = "q", mode = "n", action = "menu_close" },
				},
			},
			editor = {
				mappings = {
					{ key = "BB", mode = "v", action = "run_selection" },
					{ key = "BB", mode = "n", action = "run_file" },
					{ key = "<CR>", mode = "n", action = "run_under_cursor" },
				},
			},
			result = {
				mappings = {
					{ key = "L", mode = "", action = "page_next" },
					{ key = "H", mode = "", action = "page_prev" },
					{ key = "E", mode = "", action = "page_last" },
					{ key = "F", mode = "", action = "page_first" },
					{ key = "yaj", mode = "n", action = "yank_current_json" },
					{ key = "yaj", mode = "v", action = "yank_selection_json" },
					{ key = "yaJ", mode = "", action = "yank_all_json" },
					{ key = "yac", mode = "n", action = "yank_current_csv" },
					{ key = "yac", mode = "v", action = "yank_selection_csv" },
					{ key = "yaC", mode = "", action = "yank_all_csv" },
					{ key = "<C-c>", mode = "", action = "cancel_call" },
				},
			},
			call_log = {
				mappings = {
					{ key = "<CR>", mode = "", action = "show_result" },
					{ key = "<C-c>", mode = "", action = "cancel_call" },
				},
			},
		})
	end,
}
