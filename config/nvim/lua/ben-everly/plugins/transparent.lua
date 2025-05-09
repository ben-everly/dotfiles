return {
	'xiyaowong/transparent.nvim',
	config = function()
		require('transparent').setup({
			extra_groups = {
				'NormalFloat',
				'NvimTreeNormal',
				'FloatBorder',
			},
		})
		vim.cmd.TransparentEnable()
	end,
}
