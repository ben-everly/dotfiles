return {
	'folke/tokyonight.nvim',
	config = function()
		vim.cmd.colorscheme 'tokyonight-night'
		--tokyonight
		--tokyonight-night
		--tokyonight-storm
		--tokyonight-day
		--tokyonight-moon
		vim.api.nvim_set_hl(0, "Normal", { bg = 'none' })
	end,
}
