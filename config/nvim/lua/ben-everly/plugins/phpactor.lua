return {
	"gbprod/phpactor.nvim",
	ft = "php",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"neovim/nvim-lspconfig",
	},
	opts = {
		install = {
			bin = vim.fn.stdpath("data") .. "/mason/packages/phpactor/phpactor.phar",
		},
		lspconfig = {
			enabled = false, -- Using our own lsp configuration in config/nvim/lsp/phpactor.lua
		},
	},
}
