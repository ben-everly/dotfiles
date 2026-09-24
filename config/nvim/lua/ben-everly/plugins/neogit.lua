return {
	"NeogitOrg/neogit",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"sindrets/diffview.nvim",
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		require("neogit").setup({ kind = "auto", graph_style = "unicode" })

		-- Neogit shares one status instance per repo but only treats its buffer
		-- as open when it's in the original window of the current tab. Opening
		-- it any other time (another tab, after a split or <C-w>T) orphans the
		-- existing buffer, whose mappings then error once either one is closed.
		-- Focus the existing buffer wherever it is instead.
		local Status = require("neogit.buffers.status")
		local open = Status.open
		function Status:open(kind)
			local buf = self.buffer
			if buf and vim.api.nvim_buf_is_valid(buf.handle) then
				local win = vim.fn.win_findbuf(buf.handle)[1]
				if win then
					buf.win_handle = win
					vim.api.nvim_set_current_win(win)
					return self
				end
			end
			return open(self, kind)
		end

		vim.keymap.set("n", "<leader>gs", require("neogit").open)
	end,
}
