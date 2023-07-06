return {
	'nvim-lualine/lualine.nvim',
	requires = { 'nvim-tree/nvim-web-devicons', opt = true },
	config = function()
		require 'lualine'.setup({
			options = {
				theme = 'tokyonight',
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
	end
}
