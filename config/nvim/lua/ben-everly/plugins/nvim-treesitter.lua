return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter").setup()
		require("nvim-treesitter").install({
			"html",
			"php_only",
			"php",
			"bash",
			"css",
			"javascript",
			"lua",
			"c",
			"c_sharp",
			"cmake",
			"cpp",
			"dockerfile",
			"git_config",
			"git_rebase",
			"go",
			"graphql",
			"vue",
			"xml",
			"regex",
			"htmldjango",
			"yaml",
			"toml",
			"sql",
			"scss",
			"sxhkdrc",
			"rust",
			"svelte",
			"ssh_config",
			"vim",
			"yuck",
			"typescript",
			"markdown",
			"markdown_inline",
		})

		vim.opt.foldmethod = "expr"
		vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
		vim.opt.foldlevel = 99
		vim.opt.foldlevelstart = 99
	end,
}
