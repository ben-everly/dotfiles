return {
	"williamboman/mason-lspconfig.nvim",
	dependencies = {
		"williamboman/mason.nvim",
		"neovim/nvim-lspconfig",
		"nanotee/sqls.nvim",
	},
	config = function()
		require("mason-lspconfig").setup()
	end,
}
