require 'ben-everly'

vim.g.mapleader = ' '

vim.opt.shortmess:append('c')

-- airline settings
vim.g.airline_powerline_fonts = 1
vim.g['airline#extensions#tabline#enabled'] = 1

-- snippets settings
vim.g.ultisnips_php_scalar_types = 1

-- general settings
vim.keymap.set('n', '<leader>w', ':w!<cr>')
vim.keymap.set('n', '<leader>q', ':bd<cr>')
vim.keymap.set('n', '<leader>l', ':ls<cr>')
vim.keymap.set('n', '<leader><C-t>', ':enew<cr>')
vim.keymap.set('n', '<leader><C-w>', ':bp|bd #<cr>')
vim.keymap.set('n', '<leader>.', ':bnext<cr>')
vim.keymap.set('n', '<leader>,', ':bprevious<cr>')
vim.keymap.set('n', '<c-w><s-j>', ':res -10<cr>')
vim.keymap.set('n', '<c-w><s-k>', ':res +10<cr>')
vim.keymap.set('n', '<c-w><s-l>', ':vert res -10<cr>')
vim.keymap.set('n', '<c-w><s-h>', ':vert res +10<cr>')
vim.cmd([[
vnoremap <silent> * :<C-U>
	\let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
	\gvy/<C-R>=&ic?'\c':'\C'<CR><C-R><C-R>=substitute(
	\escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
	\gVzv:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
	\let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
	\gvy?<C-R>=&ic?'\c':'\C'<CR><C-R><C-R>=substitute(
	\escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
	\gVzv:call setreg('"', old_reg, old_regtype)<CR>
]])
vim.opt.signcolumn = 'auto:1-9'
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
vim.opt.listchars = { tab = '» ', trail = '·', eol = '↵' }
vim.opt.cmdheight = 2
vim.opt.updatetime = 300
vim.opt.inccommand = 'nosplit'
vim.opt.tabstop = 4
vim.opt.clipboard = 'unnamed,unnamedplus'
vim.opt.foldmethod = 'expr'
vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
vim.g.vimsyn_embed = 'l'

local folding_group = vim.api.nvim_create_augroup('folding', { clear = true })
vim.api.nvim_create_autocmd('Syntax', { pattern = '*', group = folding_group, command = 'normal zR' })

if vim.fn.filereadable(vim.env.HOME .. '/.vim/vimrc.local') ~= 0
then
	vim.cmd([[ source ~/.vim/vimrc.local ]])
end
