return {
	'pwntester/octo.nvim',
	requires = {
		'nvim-lua/plenary.nvim',
		'nvim-telescope/telescope.nvim',
		'nvim-tree/nvim-web-devicons'
	},
	config = function ()
		require('octo').setup({
			default_to_projects_v2 = true
		})
		local octo = require('octo.commands').octo
		vim.keymap.set('n', '<leader>fp', function () octo('pr', 'list') end, { silent = true })
		vim.keymap.set('n', '<leader>pc', function () octo('pr', 'create') end, { silent = true })
	end,
}
