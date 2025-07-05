return {
	"nvimtools/none-ls.nvim",
	config = function()
		require("null-ls").setup({
			border = "single",
			temp_dir = vim.fn.stdpath("cache"),
		})
	end,
}
