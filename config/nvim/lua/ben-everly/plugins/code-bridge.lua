return {
	"samir-roy/code-bridge.nvim",
	config = function()
		require("code-bridge").setup({
			tmux = {
				switch_to_target = false, -- Don't try to switch if we aren't using tmux
			},
		})

		vim.keymap.set("n", "<leader>ct", ":CodeBridgeTmux<CR>", { desc = "Send file to claude" })
		vim.keymap.set("v", "<leader>ct", ":CodeBridgeTmux<CR>", { desc = "Send selection to claude" })
		vim.keymap.set("n", "<leader>ca", ":CodeBridgeTmuxAll<CR>", { desc = "Send all buffers to claude" })

		vim.keymap.set("n", "<leader>ci", ":CodeBridgeTmuxInteractive<CR>", { desc = "Interactive prompt to claude" })
		vim.keymap.set("n", "<leader>cd", ":CodeBridgeTmuxDiff<CR>", { desc = "Send git diff to claude" })
		vim.keymap.set("n", "<leader>cr", ":CodeBridgeTmuxRecent<CR>", { desc = "Send recent files to claude" })
		vim.keymap.set("n", "<leader>ce", ":CodeBridgeTmuxDiagnostics<CR>", { desc = "Send diagnostics to claude" })
	end,
}
