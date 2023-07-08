local packer = {}
packer.install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
packer.is_installed = vim.fn.empty(vim.fn.glob(packer.install_path)) == 0
packer.install = function()
	print('installing')
	vim.fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', packer.install_path })
	vim.cmd [[packadd packer.nvim]]
end
packer.setup = function()
	local lib = require 'packer'
	return lib.startup(function(use)
		use('wbthomason/packer.nvim')

		use(require 'ben-everly.plugins.nvim-treesitter')
		use({ 'nvim-treesitter/nvim-treesitter-context' })
		use(require 'ben-everly.plugins.nvim-treesitter-textobjects')

		use(require 'ben-everly.plugins.nvim-dap')
		use(require 'ben-everly.plugins.nvim-dap-ui')

		use(require 'ben-everly.plugins.coc')

		use(require 'ben-everly.plugins.neotest')

		use(require 'ben-everly.plugins.telescope')
		use(require 'ben-everly.plugins.telescope-file-browser')

		use(require 'ben-everly.plugins.vim-fugitive')
		use(require 'ben-everly.plugins.vim-rhubarb')
		use(require 'ben-everly.plugins.gitsigns')

		use(require 'ben-everly.plugins.copilot')
		use(require 'ben-everly.plugins.vim-snippets')
		use(require 'ben-everly.plugins.vim-yoink')
		use(require 'ben-everly.plugins.vim-commentary')
		use(require 'ben-everly.plugins.nvim-autopairs')
		use('wellle/targets.vim')
		use('tpope/vim-surround')
		use('tpope/vim-sleuth')
		use('tpope/vim-repeat')
		use({ 'mg979/vim-visual-multi', branch = 'master' })

		use(require 'ben-everly.plugins.toggleterm')
		use({ 'tpope/vim-dadbod', ft = { 'sql', 'mysql' } })
		use('lambdalisue/suda.vim')

		use(require 'ben-everly.plugins.colorschemes.tokyonight')
		use(require 'ben-everly.plugins.lualine')
		use(require 'ben-everly.plugins.indent-blankline')

		-- treesitter doesn't have a grammar for blade yet
		use('jwalton512/vim-blade')

		if not packer.is_installed then
			lib.sync()
		else
			lib.on_complete()
		end
	end)
end
return packer
