return {
	"rcarriga/nvim-dap-ui",
	dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
	config = function()
		local dap, dapui = require("dap"), require("dapui")
		vim.keymap.set("n", "<M-k>", dapui.eval, { desc = "Debug: evaluate expression" })
		vim.keymap.set("v", "<M-k>", dapui.eval, { desc = "Debug: evaluate selection" })
		vim.keymap.set("n", "<leader>dn", require("dapui").toggle, { desc = "Debug: toggle UI" })
		dapui.setup()
		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
	end,
}
