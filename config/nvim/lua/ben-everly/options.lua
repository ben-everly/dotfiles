vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.vimsyn_embed = 'l'
vim.opt.shortmess:append('c')
vim.opt.signcolumn = 'auto:1-9'
vim.opt.sidescrolloff = 2
vim.opt.scrolloff = 3
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.lazyredraw = true
vim.opt.autoread = true
vim.opt.hidden = true
vim.opt.startofline = false
vim.opt.cursorline = true
vim.opt.ignorecase = true
vim.opt.shell = 'zsh'
vim.opt.wrap = false
vim.opt.list = true
vim.opt.listchars = { tab = '  ', trail = '·', eol = '↵', extends = '>', precedes = '<' }
vim.opt.cmdheight = 2
vim.opt.updatetime = 300
vim.opt.inccommand = 'nosplit'
vim.opt.tabstop = 4
vim.opt.clipboard = 'unnamed,unnamedplus'
vim.opt.autowriteall = true

local autowrite_group = vim.api.nvim_create_augroup('autowrite', { clear = true })
vim.api.nvim_create_autocmd('FocusLost', { pattern = '*', group = autowrite_group, command = 'silent! wa' })

local folding_group = vim.api.nvim_create_augroup('folding', { clear = true })
vim.api.nvim_create_autocmd('Syntax', { pattern = '*', group = folding_group, command = 'normal zR' })

if vim.fn.filereadable(vim.env.HOME .. '/.vim/vimrc.local') ~= 0 then
	vim.cmd([[ source ~/.vim/vimrc.local ]])
end
