return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<c-f>",
			function()
				require("conform").format({ async = true })
			end,
			mode = "",
			desc = "Format buffer",
		},
	},
	---@module "conform"
	---@type conform.setupOpts
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			php = { "pint" },
			blade = { "blade-formatter" },
			markdown = { "prettierd", "markdownlint", "injected" },
			sql = { "sql-formatter" },
			toml = { "taplo" },
		},
		formatters = {
			injected = {
				-- dont mangle fenced code blocks nested in a blockquote where the code
				-- contains a blank line
				condition = function(self, ctx)
					if not require("conform.formatters.injected").condition(self, ctx) then
						return false
					end
					local fence, blank = false, false
					for _, line in ipairs(vim.api.nvim_buf_get_lines(ctx.buf, 0, -1, false)) do
						fence = fence or line:match("^%s*>[%s>]*```") ~= nil
						blank = blank or line:match("^%s*>[%s>]*$") ~= nil
						if fence and blank then
							return false
						end
					end
					return true
				end,
			},
		},
		default_format_opts = {
			lsp_format = "fallback",
		},
		format_on_save = { timeout_ms = 2000 },
	},
}
