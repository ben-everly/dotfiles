local ensure_packer = function()
	local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
	if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
		vim.fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
		vim.cmd [[packadd packer.nvim]]
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

local packer = require 'packer'
return packer.startup(function(use)
	use 'wbthomason/packer.nvim'
	use 'tpope/vim-sensible'
	use { 'morhetz/gruvbox', config = require 'ben-everly.plugins.gruvbox'}
	use 'tpope/vim-fugitive'
	use 'tpope/vim-rhubarb'
	use { 'neoclide/coc.nvim', branch = 'release', config = require 'ben-everly.plugins.coc' }
	use 'vim-airline/vim-airline'
	use 'ben-everly/vim-snippets'
	use 'svermeulen/vim-yoink'
	use { 'nvim-treesitter/nvim-treesitter', run = function()
		require('nvim-treesitter.install').update({ with_sync = true })()
	end }
	use { 'nvim-treesitter/nvim-treesitter-context' }
	use { 'nvim-treesitter/nvim-treesitter-textobjects', after = 'nvim-treesitter', config = require 'ben-everly.plugins.nvim-treesitter-textobjects' }
	use { 'mfussenegger/nvim-dap', config = require 'ben-everly.plugins.nvim-dap' }
	use { 'rcarriga/nvim-dap-ui', after = 'nvim-dap', config = require 'ben-everly.plugins.nvim-dap-ui' }
	use { 'tpope/vim-dadbod', ft = { 'sql', 'mysql' } }
	use 'jiangmiao/auto-pairs'
	use 'romainl/vim-qf'
	use 'tpope/vim-commentary'
	use 'tpope/vim-surround'
	use 'tpope/vim-sleuth'
	use 'tpope/vim-repeat'
	use { 'nvim-telescope/telescope.nvim', tag = '0.1.0', requires = 'nvim-lua/plenary.nvim', config = require 'ben-everly.plugins.telescope' }
	use { 'nvim-telescope/telescope-file-browser.nvim', after = 'telescope.nvim', config = require 'ben-everly.plugins.telescope-file-browser' }
	use 'github/copilot.vim'
	use { 'akinsho/toggleterm.nvim', tag = '*' }
	use { 'mg979/vim-visual-multi', branch = 'master' }
	use 'lambdalisue/suda.vim'
	use {
		'nvim-neotest/neotest',
		requires = {
			'nvim-lua/plenary.nvim',
			'antoinemadec/FixCursorHold.nvim',
			'theutz/neotest-pest',
		}
	}

	-- treesitter doesn't have a grammar for blade yet
	use 'jwalton512/vim-blade'
	if packer_bootstrap then
		packer.sync()
	else
		packer.on_complete()
	end
end)