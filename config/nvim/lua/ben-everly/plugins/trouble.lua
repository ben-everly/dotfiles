return {
	"folke/trouble.nvim",
	cmd = "Trouble",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	init = function()
		vim.api.nvim_create_autocmd("BufRead", {
			group = vim.api.nvim_create_augroup("trouble_qflist", { clear = true }),
			callback = function(ev)
				if vim.bo[ev.buf].buftype == "quickfix" then
					vim.schedule(function()
						vim.cmd("cclose")
						vim.cmd("Trouble qflist open")
					end)
				end
			end,
		})
	end,
	---@module "trouble"
	---@type trouble.Config
	opts = {
		focus = true,
	},
	keys = {
		{ "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (workspace)" },
		{ "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Diagnostics (buffer)" },
		{
			"<leader>xe",
			"<cmd>Trouble diagnostics toggle filter.severity=vim.diagnostic.severity.ERROR<cr>",
			desc = "Diagnostics (errors only)",
		},
		{ "<leader>xq", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix list" },
		{ "<leader>xl", "<cmd>Trouble loclist toggle<cr>", desc = "Location list" },
		{
			"<leader>xr",
			"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
			desc = "LSP references/definitions",
		},
		{
			"]q",
			function()
				if require("trouble").is_open() then
					vim.cmd("Trouble next jump=true")
				else
					local ok, err = pcall(vim.cmd.cnext)
					if not ok then
						vim.notify(err, vim.log.levels.ERROR)
					end
				end
			end,
			desc = "Next trouble/quickfix item",
		},
		{
			"[q",
			function()
				if require("trouble").is_open() then
					vim.cmd("Trouble prev jump=true")
				else
					local ok, err = pcall(vim.cmd.cprev)
					if not ok then
						vim.notify(err, vim.log.levels.ERROR)
					end
				end
			end,
			desc = "Previous trouble/quickfix item",
		},
	},
}
