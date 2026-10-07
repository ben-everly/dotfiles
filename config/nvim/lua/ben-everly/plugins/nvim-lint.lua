return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")

		lint.linters_by_ft = {
			markdown = { "markdownlint" },
			php = { "phpmd", "phpstan" },
		}

		-- nvim-lint's builtin args use the PHPMD 2 positional CLI, which PHPMD 3 rejects.
		local phpmd = lint.linters.phpmd
		lint.linters.phpmd = function()
			local args = { "analyze", "--format=json", "--no-progress" }
			for _, ruleset in ipairs({ "phpmd.xml", vim.env.HOME .. "/.config/phpmd/phpmd.xml" }) do
				if vim.fn.filereadable(ruleset) == 1 then
					table.insert(args, "--ruleset=" .. ruleset)
					break
				end
			end
			-- Symfony Console warns on "-" unless it is the last argument.
			table.insert(args, "-")
			return vim.tbl_extend("force", phpmd, { args = args })
		end

		vim.diagnostic.config({
			underline = false,
		}, lint.get_namespace("phpmd"))

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				lint.try_lint()
			end,
		})
	end,
}
