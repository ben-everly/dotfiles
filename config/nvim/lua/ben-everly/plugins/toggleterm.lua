return {
	'akinsho/toggleterm.nvim',
	tag = '*',
	config = function()
		require 'toggleterm'.setup {
			open_mapping = [[<c-\>]],
			insert_mappings = true,
			terminal_mappings = true,
		}
	end
}
