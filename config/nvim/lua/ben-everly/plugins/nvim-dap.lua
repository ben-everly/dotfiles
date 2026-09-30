return {
	"mfussenegger/nvim-dap",
	config = function()
		local dap = require("dap")
		vim.keymap.set("n", "<leader>d<cr>", dap.continue, { desc = "Debug: continue" })
		vim.keymap.set("n", "<leader>dq", function()
			dap.terminate()
			require("dapui").close()
			dap.close()
		end, { desc = "Debug: quit" })
		vim.keymap.set("n", "<leader>dr", dap.restart, { desc = "Debug: restart" })
		vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Debug: toggle breakpoint" })
		vim.keymap.set("n", "<leader>dj", dap.step_over, { desc = "Debug: step over" })
		vim.keymap.set("n", "<leader>dl", dap.step_into, { desc = "Debug: step into" })
		vim.keymap.set("n", "<leader>dh", dap.step_out, { desc = "Debug: step out" })
		vim.keymap.set("n", "<leader>dt", dap.repl.open, { desc = "Debug: open REPL" })
	end,
}
