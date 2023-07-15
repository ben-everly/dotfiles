vim.g.mapleader = ' '
vim.keymap.set('n', '<C-t>', vim.cmd.enew)
vim.keymap.set('n', '<C-w>', ':bp|bd #<cr>')
vim.keymap.set('n', '<m-]>', ':winc w<cr>')
vim.keymap.set('n', '<m-[>', ':winc W<cr>')
vim.keymap.set('n', '<TAB>', vim.cmd.bnext)
vim.keymap.set('n', '<S-TAB>', vim.cmd.bprevious)
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
