return {
	'tpope/vim-commentary',
	config = function()
		vim.keymap.set('x', '<leader>c', ' <Plug>Commentary')
		vim.keymap.set('n', '<leader>c', ' <Plug>Commentary')
		vim.keymap.set('o', '<leader>c', ' <Plug>Commentary')
		vim.keymap.set('n', '<leader>cc', '<Plug>CommentaryLine')
		vim.keymap.set('n', '<leader>cu', '<Plug>Commentary<Plug>Commentary')
	end
}
