return {
	'nvim-telescope/telescope.nvim',
	tag = '0.1.2',
	requires = 'nvim-lua/plenary.nvim',
	config = function()
		local builtin = require 'telescope.builtin'
		vim.keymap.set('n', '<leader>ff', builtin.find_files)
		vim.keymap.set('n', '<leader>fF', builtin.git_files)
		vim.keymap.set('n', '<leader>fg', builtin.live_grep)
		vim.keymap.set('n', '<leader>fb', builtin.buffers)
		vim.keymap.set('n', '<leader>fh', builtin.help_tags)
		vim.keymap.set('n', '<leader>fj', builtin.jumplist)
		vim.keymap.set('n', '<leader>fr', builtin.registers)
		vim.keymap.set('n', '<leader>f/', builtin.search_history)
		vim.keymap.set('n', '<leader>gb', builtin.git_branches)
		vim.keymap.set('n', '<leader>gl', builtin.git_commits)
		vim.keymap.set('n', '<leader>gL', builtin.git_bcommits)
		vim.keymap.set('n', '<leader>fGs', builtin.git_status)
		vim.keymap.set('n', '<leader>fGS', builtin.git_stash)
		vim.keymap.set('n', '<leader>b', builtin.treesitter)
		vim.keymap.set('n', '<leader>fs', builtin.lsp_workspace_symbols)
		require 'telescope'.setup {
			defaults = {
				mappings = {
					i = {
						['<C-j>'] = 'move_selection_next',
						['<C-k>'] = 'move_selection_previous',
					},
				},
			},
		}
	end
}
