return {
	"folke/trouble.nvim",
	cmd = "Trouble",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	---@module "trouble"
	---@type trouble.Config
	opts = {
		-- land in the list so it can be worked through without a second keypress
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
			-- references/definitions/implementations in a sidebar that stays open,
			-- unlike the telescope gr/gd/gi pickers
			"<leader>xr",
			"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
			desc = "LSP references/definitions",
		},
		-- step through the trouble list when it's open, quickfix otherwise
		{
			"]q",
			function()
				if require("trouble").is_open() then
					require("trouble").next({ jump = true })
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
					require("trouble").prev({ jump = true })
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
