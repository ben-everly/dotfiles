vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.keymap.set('n', '<C-t>', vim.cmd.enew)
vim.keymap.set('n', '<C-.>', vim.cmd.bnext)
vim.keymap.set('n', '<C-,>', vim.cmd.bprevious)
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

local qf_group = vim.api.nvim_create_augroup('qf', { clear = true })
vim.api.nvim_create_autocmd('FileType', { pattern = 'qf', group = qf_group, callback = function()
	vim.keymap.set("n", "<CR>", "<CR>:ccl<CR>", { buffer = true })
end })
