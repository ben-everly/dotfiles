return {
	'nvim-treesitter/nvim-treesitter-textobjects',
	after = 'nvim-treesitter',
	config = function()
		local ts_repeat_move = require 'nvim-treesitter.textobjects.repeatable_move'
		vim.keymap.set({ 'n', 'x', 'o' }, ';', ts_repeat_move.repeat_last_move_next)
		vim.keymap.set({ 'n', 'x', 'o' }, ',', ts_repeat_move.repeat_last_move_previous)
		vim.keymap.set({ 'n', 'x', 'o' }, 'f', ts_repeat_move.builtin_f)
		vim.keymap.set({ 'n', 'x', 'o' }, 'F', ts_repeat_move.builtin_F)
		vim.keymap.set({ 'n', 'x', 'o' }, 't', ts_repeat_move.builtin_t)
		vim.keymap.set({ 'n', 'x', 'o' }, 'T', ts_repeat_move.builtin_T)
	end
}
