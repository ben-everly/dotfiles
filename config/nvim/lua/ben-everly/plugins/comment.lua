return {
	'numToStr/Comment.nvim',
	config = function()
		require('Comment').setup({
			toggler = {
				line = '//',
				block = '/*',
			},
			opleader = {
				block = '<leader>//',
			},
		})
		vim.keymap.set('v', '//', '<Plug>(comment_toggle_blockwise_visual)')
	end,
}
