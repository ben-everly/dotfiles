return {
	'nvimdev/lspsaga.nvim',
	config = function()
		require('lspsaga').setup({
			lightbulb = {
				enable = false,
				sign = false,
				virtual_text = false,
				enable_in_insert = false,
			},
			outline = {
				close_after_jump = true,
				keys = {
					jump = '<cr>',
				}
			},
			beacon = {
				enable = false,
			},
			finder = {
				keys = {
					toggle_or_open = '<cr>',
				}
			}
		})
		vim.keymap.set({ 'n', 'v' }, '<leader>ca', ':Lspsaga code_action<CR>')
		vim.keymap.set('n', '[e', ':Lspsaga diagnostic_jump_prev<CR>')
		vim.keymap.set('n', ']e', ':Lspsaga diagnostic_jump_next<CR>')
		vim.keymap.set('n', 'gr', ':Lspsaga finder<CR>')
		vim.keymap.set({ 'n', 'v' }, 'K', ':Lspsaga hover_doc<CR>')
		vim.keymap.set('n', 'go', ':Lspsaga outline<CR>')
		vim.keymap.set('n', '<leader>rn', ':Lspsaga rename<CR>')
	end,
	dependencies = {
		'nvim-treesitter/nvim-treesitter',
		'nvim-tree/nvim-web-devicons',
	}
}
