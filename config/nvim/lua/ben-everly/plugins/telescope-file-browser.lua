return {
	'nvim-telescope/telescope-file-browser.nvim',
	dependencies = 'telescope.nvim',
	config = function()
		vim.keymap.set('n', '<space>ft', function()
			require 'telescope'.extensions.file_browser.file_browser {
				grouped = true,
				collapse_dirs = true,
			}
		end, { noremap = true })
		vim.keymap.set('n', '<space>fT', function()
			require 'telescope'.extensions.file_browser.file_browser {
				grouped = true,
				collapse_dirs = true,
				path = '%:p:h',
				select_buffer = true
			}
		end, { noremap = true })
	end
}
