return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				null_ls.builtins.diagnostics.phpmd.with({
					extra_args = function()
						if vim.fn.filereadable("phpmd.xml") == 1 then
							return { "phpmd.xml" }
						elseif vim.fn.filereadable(vim.env.HOME .. "/.config/phpmd/phpmd.xml") == 1 then
							return { vim.env.HOME .. "/.config/phpmd/phpmd.xml" }
						else
							return { "cleancode,codesize,controversial,design,naming,unusedcode" }
						end
					end,
				}),
			},
			border = "single",
			temp_dir = vim.fn.stdpath("cache"),
		})
	end,
}
