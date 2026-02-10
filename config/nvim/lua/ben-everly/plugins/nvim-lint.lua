return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")

		lint.linters_by_ft = {
			markdown = { "markdownlint" },
			php = { "phpmd", "phpstan" },
		}

		-- Custom phpmd configuration
		local phpmd = lint.linters.phpmd
		phpmd.args = {
			"-",
			"json",
			function()
				if vim.fn.filereadable("phpmd.xml") == 1 then
					return "phpmd.xml"
				elseif vim.fn.filereadable(vim.env.HOME .. "/.config/phpmd/phpmd.xml") == 1 then
					return vim.env.HOME .. "/.config/phpmd/phpmd.xml"
				else
					return "cleancode,codesize,controversial,design,naming,unusedcode"
				end
			end,
		}

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				lint.try_lint()
			end,
		})
	end,
}
