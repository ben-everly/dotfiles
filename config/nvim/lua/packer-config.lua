local packer_augroup = vim.api.nvim_create_augroup('packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
	pattern = 'plugins.lua',
	group = packer_augroup,
	command = 'PackerSync',
	desc = 'Sync packer on plugins.lua save'
})

local ensure_packer = function()
	local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
	if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
		vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
		vim.cmd [[packadd packer.nvim]]
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

local packer = require('packer')
return packer.startup(function(use)
	use 'wbthomason/packer.nvim'
	use 'tpope/vim-sensible'
	use 'morhetz/gruvbox'
	use { 'preservim/nerdtree', opt = true, cmd = { 'NERDTreeToggle', 'NERDTreeFind' } }
	use 'tpope/vim-fugitive'
	use 'tpope/vim-rhubarb'
	use { 'neoclide/coc.nvim', branch = 'release' }
	use 'vim-airline/vim-airline'
	use 'ludovicchabant/vim-gutentags'
	use 'ben-everly/vim-snippets'
	use 'svermeulen/vim-yoink'
	use { 'nvim-treesitter/nvim-treesitter-context', requires = {
		'nvim-treesitter/nvim-treesitter'
	} }
	use 'mfussenegger/nvim-dap'
	use 'rcarriga/nvim-dap-ui'
	use { 'tpope/vim-dadbod', ft = { 'sql', 'mysql' } }
	use 'jiangmiao/auto-pairs'
	use 'romainl/vim-qf'
	use 'tpope/vim-commentary'
	use 'tpope/vim-surround'
	use 'tpope/vim-sleuth'
	use { 'nvim-telescope/telescope.nvim', tag = '0.1.0', requires = {
		'nvim-lua/plenary.nvim'
	} }
	use "nvim-telescope/telescope-file-browser.nvim"
	use 'github/copilot.vim'
	use {"akinsho/toggleterm.nvim", tag = '*', config = function()
		require("toggleterm").setup()
	end}
	use { 'mg979/vim-visual-multi', branch = 'master' }
	use { 'lambdalisue/suda.vim' }

	-- treesitter doesn't have a grammar for blade yet
	use 'jwalton512/vim-blade'
	if packer_bootstrap then
		packer.sync()
	else
		packer.on_complete()
	end
end)
