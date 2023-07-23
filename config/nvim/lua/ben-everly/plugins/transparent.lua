return {
	'xiyaowong/transparent.nvim',
	config = function()
		require('transparent').setup({
			extra_groups = {
				'GitSignsAddLn',
				'GitSignsChangeLn',
				'GitSignsDeleteLn',
				'NormalFloat',
				'NvimTreeNormal',
			},
		})
		vim.cmd.TransparentEnable()
	end,
}
