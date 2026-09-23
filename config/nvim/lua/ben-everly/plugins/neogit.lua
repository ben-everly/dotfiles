return {
	"NeogitOrg/neogit",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"sindrets/diffview.nvim",
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		require("neogit").setup({ kind = "auto", graph_style = "unicode" })
		-- Neogit shares one status instance per repo but only checks the current
		-- tab for an open status buffer. Opening it from a second tab orphans the
		-- first buffer, whose mappings then error once either one is closed.
		vim.keymap.set("n", "<leader>gs", function()
			for _, win in ipairs(vim.api.nvim_list_wins()) do
				if vim.bo[vim.api.nvim_win_get_buf(win)].filetype == "NeogitStatus" then
					vim.api.nvim_set_current_win(win)
					return
				end
			end
			require("neogit").open()
		end)
	end,
}
