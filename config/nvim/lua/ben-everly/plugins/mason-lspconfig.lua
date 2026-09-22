return {
	"mason-org/mason-lspconfig.nvim",
	dependencies = {
		"mason-org/mason.nvim",
		"neovim/nvim-lspconfig",
		"nanotee/sqls.nvim",
	},
	config = function()
		require("mason-lspconfig").setup()
	end,
}
