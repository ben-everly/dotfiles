return function()
	vim.keymap.set('n', '<leader>gp', ':Git push<CR>')
	vim.keymap.set('n', '<leader>gf', ':Git fetch<CR>')
	vim.keymap.set('n', '<leader>gl', ':Gclog -50<CR>')
	vim.keymap.set('v', '<leader>gl', ":'<,'>Gclog -50<CR>")
	vim.keymap.set('n', '<leader>gH', ':GBrowse<CR>')
	vim.keymap.set('n', '<leader>gh', ':.GBrowse<CR>')
	vim.keymap.set('v', '<leader>gh', ":'<,'>GBrowse<cr>")
end
