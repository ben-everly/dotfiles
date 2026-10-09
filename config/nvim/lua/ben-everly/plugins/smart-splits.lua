return {
	"mrjones2014/smart-splits.nvim",
	-- v3 moved wezterm support to an unstable backend plugin
	tag = "v2.1.1-final",
	config = function()
		local ss = require("smart-splits")
		---@diagnostic disable-next-line: missing-fields
		ss.setup({
			multiplexer_integration = "wezterm",
		})
		vim.keymap.set({ "n", "x" }, "<C-h>", ss.move_cursor_left, { desc = "Window: move to left" })
		vim.keymap.set({ "n", "x" }, "<C-j>", ss.move_cursor_down, { desc = "Window: move to below" })
		vim.keymap.set({ "n", "x" }, "<C-k>", ss.move_cursor_up, { desc = "Window: move to above" })
		vim.keymap.set({ "n", "x" }, "<C-l>", ss.move_cursor_right, { desc = "Window: move to right" })
		vim.keymap.set("n", "<A-h>", ss.resize_left, { desc = "Window: resize left" })
		vim.keymap.set("n", "<A-j>", ss.resize_down, { desc = "Window: resize down" })
		vim.keymap.set("n", "<A-k>", ss.resize_up, { desc = "Window: resize up" })
		vim.keymap.set("n", "<A-l>", ss.resize_right, { desc = "Window: resize right" })
	end,
}
