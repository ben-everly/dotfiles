return {
	'akinsho/toggleterm.nvim',
	version = '*',
	config = function()
		require 'toggleterm'.setup {
			open_mapping = [[<c-\>]],
			insert_mappings = true,
			terminal_mappings = true,
			direction = 'vertical',
			size = 60,
		}
		vim.keymap.set('t', '<c-esc>', '<c-\\><c-n>', { noremap = true }) -- so <esc> will still work in zsh vim mode and we can exit terminal mode with <c-esc>
	end
}
