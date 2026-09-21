return {
	"numToStr/Comment.nvim",
	config = function()
		---@diagnostic disable-next-line: missing-fields
		require("Comment").setup({
			toggler = { line = "//", block = "/*" },

			opleader = { line = "<leader>//", block = "<leader>/*" },
		})
		vim.keymap.set("v", "/*", "<Plug>(comment_toggle_blockwise_visual)")
		vim.keymap.set("v", "//", "<Plug>(comment_toggle_linewise_visual)")
	end,
}
