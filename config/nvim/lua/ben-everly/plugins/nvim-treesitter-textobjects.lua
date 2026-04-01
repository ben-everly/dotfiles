return {
	"nvim-treesitter/nvim-treesitter-textobjects",
	config = function()
		local ts_repeat_move = require("nvim-treesitter-textobjects.repeatable_move")
		local ts_select = require("nvim-treesitter-textobjects.select")
		local ts_move = require("nvim-treesitter-textobjects.move")

		require("nvim-treesitter-textobjects").setup({
			select = {
				lookahead = true,
			},
			move = {
				set_jumps = false,
			},
		})

		-- Repeatable move
		vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
		vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)
		vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
		vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
		vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
		vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })

		-- Textobject select
		local select_map = function(lhs, query)
			vim.keymap.set({ "x", "o" }, lhs, function()
				ts_select.select_textobject(query)
			end)
		end
		select_map("af", "@function.outer")
		select_map("if", "@function.inner")
		select_map("ac", "@class.outer")
		select_map("ic", "@class.inner")
		select_map("ao", "@loop.outer")
		select_map("io", "@loop.inner")
		select_map("as", "@scope")
		select_map("al", "@statement.outer")
		select_map("a/", "@comment.outer")
		select_map("i/", "@comment.inner")
		select_map("a?", "@conditional.outer")
		select_map("i?", "@conditional.inner")

		-- Textobject move
		local move_map = function(lhs, fn, query)
			vim.keymap.set({ "n", "x", "o" }, lhs, function()
				fn(query)
			end)
		end
		move_map("]f", ts_move.goto_next_start, "@function.outer")
		move_map("]c", ts_move.goto_next_start, "@class.outer")
		move_map("]o", ts_move.goto_next_start, "@loop.outer")
		move_map("]s", ts_move.goto_next_start, "@scope")
		move_map("]F", ts_move.goto_next_end, "@function.outer")
		move_map("]C", ts_move.goto_next_end, "@class.outer")
		move_map("]O", ts_move.goto_next_end, "@loop.outer")
		move_map("[s", ts_move.goto_previous_start, "@scope")
		move_map("[f", ts_move.goto_previous_start, "@function.outer")
		move_map("[c", ts_move.goto_previous_start, "@class.outer")
		move_map("[o", ts_move.goto_previous_start, "@loop.outer")
		move_map("[F", ts_move.goto_previous_end, "@function.outer")
		move_map("[C", ts_move.goto_previous_end, "@class.outer")
		move_map("[O", ts_move.goto_previous_end, "@loop.outer")
	end,
}
