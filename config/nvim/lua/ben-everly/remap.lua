vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.keymap.set('n', '<C-t>', vim.cmd.enew)
vim.keymap.set('n', '<C-w>', vim.cmd.bd)
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

vim.keymap.set('n', '<leader>w', function()
	require'libmodal'.mode.enter('WINDOW', {
		h = function()
			vim.cmd('winc h')
			require'lualine'.refresh()
		end,
		j = function()
			vim.cmd('winc j')
			require'lualine'.refresh()
		end,
		k = function()
			vim.cmd('winc k')
			require'lualine'.refresh()
		end,
		l = function()
			vim.cmd('winc l')
			require'lualine'.refresh()
		end,
		[']'] = function()
			vim.cmd('winc w')
			require'lualine'.refresh()
		end,
		['['] = function()
			vim.cmd('winc W')
			require'lualine'.refresh()
		end,
		n = function() vim.cmd('vsp') end,
		s = function() vim.cmd('spl') end,
		x = function() vim.cmd('q') end,
		q = function() vim.cmd('q') end,
		H = function() vim.cmd('vert res +2') end,
		L = function() vim.cmd('vert res -2') end,
		K = function() vim.cmd('res +2') end,
		J = function() vim.cmd('res -2') end,
	})
end)
