return {
	'nvim-lualine/lualine.nvim',
	requires = { 'nvim-tree/nvim-web-devicons', opt = true },
	config = {
		require 'lualine'.setup({
			options = {
				theme = 'gruvbox',
			},
			sections = {
				lualine_b = {'branch', 'diff'},
				lualine_x = {'filetype'},
				lualine_z = {'selectioncount', 'searchcount', 'location'}
			},
			tabline = {
				lualine_a = {'buffers'},
				lualine_z = {'tabs'}
			},
		})
	}
}
