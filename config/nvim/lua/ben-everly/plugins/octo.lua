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
		vim.keymap.set('n', '<leader>fp', require('octo.commands').commands.pr.list, { silent = true })
		vim.api.nvim_create_autocmd('FileType', {
			pattern = {'octo'},
			callback = function ()
				vim.schedule(function ()
					vim.g.maplocalleader = ' '
					vim.keymap.set('i', '@', '@<C-x><C-o>', { silent = true, buffer = true })
					vim.keymap.set('i', '#', '#<C-x><C-o>', { silent = true, buffer = true })
				end)
			end,
		})
	end,
}
