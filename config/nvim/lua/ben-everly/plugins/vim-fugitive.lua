return {
	'tpope/vim-fugitive',
	config = function()
		vim.keymap.set('n', '<leader>gp', ':Git push<CR>')
		vim.keymap.set('n', '<leader>gf', ':Git fetch<CR>')
		vim.keymap.set('n', '<leader>gl', ':Gclog -50<CR>')
		vim.keymap.set('v', '<leader>gl', ":'<,'>Gclog -50<CR>")
	end
}
