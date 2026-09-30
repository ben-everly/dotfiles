return {
	"samir-roy/code-bridge.nvim",
	config = function()
		require("code-bridge").setup({
			tmux = {
				switch_to_target = false, -- Don't try to switch if we aren't using tmux
			},
		})

		vim.keymap.set("n", "<leader>ct", ":CodeBridgeTmux<CR>", { desc = "Claude: send file (tmux)" })
		vim.keymap.set("v", "<leader>ct", ":CodeBridgeTmux<CR>", { desc = "Claude: send selection (tmux)" })
		vim.keymap.set("n", "<leader>cb", ":CodeBridgeTmuxAll<CR>", { desc = "Claude: send all buffers (tmux)" })

		vim.keymap.set(
			"n",
			"<leader>ci",
			":CodeBridgeTmuxInteractive<CR>",
			{ desc = "Claude: interactive prompt (tmux)" }
		)
		vim.keymap.set("n", "<leader>cd", ":CodeBridgeTmuxDiff<CR>", { desc = "Claude: send git diff (tmux)" })
		vim.keymap.set("n", "<leader>cr", ":CodeBridgeTmuxRecent<CR>", { desc = "Claude: send recent files (tmux)" })
		vim.keymap.set(
			"n",
			"<leader>ce",
			":CodeBridgeTmuxDiagnostics<CR>",
			{ desc = "Claude: send diagnostics (tmux)" }
		)
	end,
}
