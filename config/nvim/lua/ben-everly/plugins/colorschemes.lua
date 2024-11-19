return {
	{
		'folke/tokyonight.nvim',
		lazy = true,
		config = function()
			vim.cmd.colorscheme 'tokyonight-night'
			--tokyonight
			--tokyonight-night
			--tokyonight-storm
			--tokyonight-day
			--tokyonight-moon
		end,
	},
	{
		'morhetz/gruvbox',
		lazy = true,
		config = function()
			vim.cmd.colorscheme 'gruvbox'
		end
	},
	{
		'sainnhe/gruvbox-material',
		lazy = false,
		priority = 1000,
		config = function ()
			vim.cmd.colorscheme 'gruvbox-material'
		end,
	}
}
