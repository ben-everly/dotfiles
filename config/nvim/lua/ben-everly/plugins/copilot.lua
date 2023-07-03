return function()
	vim.g.copilot_no_tab_map = true
	vim.keymap.set('i', '<C-Enter>', 'copilot#Accept("")',
		{ noremap = true, silent = true, expr = true, replace_keycodes = false })
end
