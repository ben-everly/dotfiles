return {
	"mrjones2014/smart-splits.nvim",
	config = function()
		local ss = require("smart-splits")
		ss.setup({
			multiplexer_integration = "wezterm",
		})
		vim.keymap.set("n", "<C-h>", ss.move_cursor_left, { desc = "Move to split/pane left" })
		vim.keymap.set("n", "<C-j>", ss.move_cursor_down, { desc = "Move to split/pane below" })
		vim.keymap.set("n", "<C-k>", ss.move_cursor_up, { desc = "Move to split/pane above" })
		vim.keymap.set("n", "<C-l>", ss.move_cursor_right, { desc = "Move to split/pane right" })
		vim.keymap.set("n", "<A-h>", ss.resize_left, { desc = "Resize split/pane left" })
		vim.keymap.set("n", "<A-j>", ss.resize_down, { desc = "Resize split/pane down" })
		vim.keymap.set("n", "<A-k>", ss.resize_up, { desc = "Resize split/pane up" })
		vim.keymap.set("n", "<A-l>", ss.resize_right, { desc = "Resize split/pane right" })
	end,
}
