return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter").setup()

		local ensure_installed = {
			"html",
			"php_only",
			"php",
			"bash",
			"blade",
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
			"latex",
		}
		local already_installed = require("nvim-treesitter.config").get_installed()
		local to_install = vim.iter(ensure_installed)
			:filter(function(parser)
				return not vim.tbl_contains(already_installed, parser)
			end)
			:totable()

		require("nvim-treesitter").install(to_install):await(function()
			vim.schedule(function()
				vim.cmd.doautoall("FileType")
			end)
		end)

		vim.api.nvim_create_autocmd("FileType", {
			pattern = "*",
			callback = function()
				if pcall(vim.treesitter.start) then
					vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end
			end,
		})

		vim.opt.foldmethod = "expr"
		vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
		vim.opt.foldlevel = 99
		vim.opt.foldlevelstart = 99
	end,
}
