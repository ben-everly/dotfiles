return {
	"NeogitOrg/neogit",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"sindrets/diffview.nvim",
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		require("neogit").setup({ kind = "auto", graph_style = "unicode" })
		vim.keymap.set("n", "<leader>gs", require("neogit").open)
	end,
}
