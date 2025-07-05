return {
	"numToStr/Comment.nvim",
	config = function()
		require("Comment").setup({
			toggler = { line = "//", block = "/*" },

			opleader = { line = "<leader>//", block = "<leader>/*" },
		})
		vim.keymap.set("v", "/*", "<Plug>(comment_toggle_blockwise_visual)")
		vim.keymap.set("v", "//", "<Plug>(comment_toggle_linewise_visual)")
	end,
}
