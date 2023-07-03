return function()
	vim.keymap.set('n', '<leader>]', '<plug>(YoinkPostPasteSwapBack)')
	vim.keymap.set('n', '<leader>[', '<plug>(YoinkPostPasteSwapForward)')
	vim.keymap.set('n', 'p', '<plug>(YoinkPaste_p)')
	vim.keymap.set('n', 'P', '<plug>(YoinkPaste_P)')
	vim.keymap.set('n', 'gp', '<plug>(YoinkPaste_gp)')
	vim.keymap.set('n', 'gP', '<plug>(YoinkPaste_gP)')
	vim.g.yoinkMaxItems = 10
	vim.g.yoinkIncludeDeleteOperations = 1
	vim.g.yoinkSavePersistently = 1
	vim.g.yoinkAutoFormatPaste = 1
	vim.g.yoinkSwapClampAtEnds = 0
end
