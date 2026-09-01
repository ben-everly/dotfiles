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
			javascript = { "prettierd" },
			javascriptreact = { "prettierd" },
			typescript = { "prettierd" },
			typescriptreact = { "prettierd" },
		},
		formatters = {
			injected = {
				options = {
					lang_to_formatters = { php = { "pint_snippet" } },
				},
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
			-- Add the <?php tag, run pint, then take it back off.
			pint_snippet = {
				format = function(_, ctx, lines, callback)
					local first = vim.iter(lines):find(function(line)
						return line:match("%S") ~= nil
					end)
					local needs_opener = not (first or ""):match("^%s*<%?")
					-- list_extend only mutates the fresh table; `lines` belongs to conform.
					local input = needs_opener and vim.list_extend({ "<?php", "" }, lines) or lines
					require("conform").format_lines({ "pint" }, input, {
						async = true,
						bufnr = ctx.buf,
						quiet = true,
					}, function(err, formatted)
						if err then
							return callback(err.message)
						end
						if needs_opener then
							local body = 1
							while formatted[body] and (formatted[body] == "" or formatted[body]:match("^<%?")) do
								body = body + 1
							end
							formatted = vim.list_slice(formatted, body)
						end
						callback(nil, formatted)
					end)
				end,
			},
		},
		default_format_opts = {
			lsp_format = "fallback",
		},
		format_on_save = { timeout_ms = 2000 },
	},
}
