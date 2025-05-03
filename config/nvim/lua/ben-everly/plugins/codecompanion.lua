return {
	'olimorris/codecompanion.nvim',
	opts = {
		extensions = {
			vectorcode = {
				opts = { add_tool = true, add_slash_command = true, tool_opts = {} },
			},
		}
	},
	dependencies = {
		'nvim-lua/plenary.nvim',
		'nvim-treesitter/nvim-treesitter',
		'Davidyz/VectorCode',
	},
	init = function()
		vim.keymap.set({ "n", "v" }, "<C-a>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
		vim.keymap.set({ "n", "v" }, "<leader>a", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
		vim.keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })
		vim.cmd([[cab cc CodeCompanion]])
	end,
}
