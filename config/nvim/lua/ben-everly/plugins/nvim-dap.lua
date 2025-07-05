return {
	"mfussenegger/nvim-dap",
	config = function()
		local dap = require("dap")
		vim.keymap.set("n", "<leader>d<cr>", dap.continue)
		vim.keymap.set("n", "<leader>dq", function()
			dap.terminate()
			require("dapui").close()
			dap.close()
		end)
		vim.keymap.set("n", "<leader>dr", dap.restart)
		vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint)
		vim.keymap.set("n", "<leader>dj", dap.step_over)
		vim.keymap.set("n", "<leader>dl", dap.step_into)
		vim.keymap.set("n", "<leader>dh", dap.step_out)
		vim.keymap.set("n", "<leader>dt", dap.repl.open)

		dap.adapters.php = {
			type = "executable",
			command = "node",
			args = {
				"/home/beneverly/.local/lib/php-debug-client/out/phpDebug.js",
			},
		}

		dap.configurations.php = {
			{
				type = "php",
				request = "launch",
				name = "Listen for Xdebug",
				port = 9003,
				log = true,
				pathMappings = { ["/var/www/html/"] = "${workspaceFolder}" },
			},
		}
	end,
}
