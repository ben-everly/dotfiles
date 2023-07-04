vim.g.mapleader = ' '
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
