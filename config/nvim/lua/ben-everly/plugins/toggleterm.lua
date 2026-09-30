return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		require("toggleterm").setup({
			open_mapping = [[<c-\>]],
			persist_mode = false,
			insert_mappings = true,
			terminal_mappings = true,
			direction = "vertical",
			size = 70,
		})
		vim.keymap.set("t", "<c-esc>", "<c-\\><c-n>", { noremap = true, desc = "Terminal: exit terminal mode" }) -- so <esc> will still work in zsh vim mode and we can exit terminal mode with <c-esc>
		vim.keymap.set("t", "<C-w>", "<C-\\><C-n><C-w>", { desc = "Terminal: window command" })
	end,
}
