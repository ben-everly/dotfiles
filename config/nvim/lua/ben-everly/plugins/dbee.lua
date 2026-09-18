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
		{
			"<leader>s",
			function()
				require("dbee").toggle()
			end,
			desc = "Toggle dbee (SQL)",
		},
	},
	config = function()
		-- On close, dbee restores its window layout after wiping buffers,
		-- tripping treesitter's fold autocmd on an already-dead buffer id.
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "dbee",
			callback = function()
				vim.opt_local.foldmethod = "manual"
			end,
		})

		-- dbee fills registers with setreg(), which TextYankPost explicitly
		-- doesn't fire for, so nothing listening for yanks sees dbee's.
		-- Charwise to match the regtype setreg() would give.
		local function background_yank(text, reg)
			local buf = vim.api.nvim_create_buf(false, true)
			vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(text, "\n", { plain = true }))
			vim.bo[buf].filetype = "dbee"
			vim.api.nvim_buf_call(buf, function()
				-- 'virtualedit' would put $ past the last character, yanking a
				-- trailing space. NONE is needed over "" to beat a global value.
				vim.cmd("setlocal virtualedit=NONE")
				vim.cmd(string.format('normal! gg0vG$"%sy', reg))
			end)
			vim.api.nvim_buf_delete(buf, { force = true })
		end

		local function yank_action(action)
			return function()
				local reg = vim.v.register
				require("dbee").api.ui.result_do_action(action)
				background_yank(vim.fn.getreg(reg), reg)
			end
		end

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
					{ key = "yaj", mode = "n", action = yank_action("yank_current_json") },
					{ key = "yaj", mode = "v", action = yank_action("yank_selection_json") },
					{ key = "yaJ", mode = "", action = yank_action("yank_all_json") },
					{ key = "yac", mode = "n", action = yank_action("yank_current_csv") },
					{ key = "yac", mode = "v", action = yank_action("yank_selection_csv") },
					{ key = "yaC", mode = "", action = yank_action("yank_all_csv") },
					{ key = "<C-c>", mode = "", action = "cancel_call" },
				},
			},
			call_log = {
				mappings = {
					{ key = "<CR>", mode = "", action = "show_result" },
					{ key = "<C-c>", mode = "", action = "cancel_call" },
					{
						key = "yq",
						mode = "n",
						action = function()
							-- call_log's hover preview truncates long queries, so pull
							-- the untruncated query via the result API instead.
							require("dbee").api.ui.call_log_do_action("show_result")
							local call = require("dbee").api.ui.result_get_call()
							if not call or not call.query or call.query == "" then
								vim.notify("dbee: no query to yank", vim.log.levels.WARN)
								return
							end
							background_yank(call.query, vim.v.register)
							vim.notify("dbee: yanked query")
						end,
					},
				},
			},
		})
	end,
}
