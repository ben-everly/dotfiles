return {
	'xiyaowong/transparent.nvim',
	config = function()
		require('transparent').setup({
			enable = true,
			extra_groups = {
				'GitSignsAddLn',
				'GitSignsChangeLn',
				'GitSignsDeleteLn',
				'NormalFloat',
				'NvimTreeNormal',
			},
		})
	end,
}
