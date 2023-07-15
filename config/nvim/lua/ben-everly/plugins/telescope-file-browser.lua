return {
	'nvim-telescope/telescope-file-browser.nvim',
	dependencies = 'telescope.nvim',
	config = function()
		vim.keymap.set('n', '<space>ft', require 'telescope'.extensions.file_browser.file_browser, { noremap = true })
		vim.keymap.set('n', '<space>fT', function()
			require 'telescope'.extensions.file_browser.file_browser { path = '%:p:h', select_buffer = true }
		end, { noremap = true })
	end
}
