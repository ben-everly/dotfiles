require 'ben-everly.options'
require 'ben-everly.remap'
require 'ben-everly.plugins'

local folding_group = vim.api.nvim_create_augroup('folding', { clear = true })
vim.api.nvim_create_autocmd('Syntax', { pattern = '*', group = folding_group, command = 'normal zR' })

if vim.fn.filereadable(vim.env.HOME .. '/.vim/vimrc.local') ~= 0 then
		vim.cmd([[ source ~/.vim/vimrc.local ]])
end
