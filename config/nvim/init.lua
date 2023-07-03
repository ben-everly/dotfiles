require 'ben-everly'

vim.g.mapleader = ' '

-- Fugitive settings
vim.keymap.set('n', '<leader>gp', ':Git push<CR>')
vim.keymap.set('n', '<leader>gf', ':Git fetch<CR>')
vim.keymap.set('n', '<leader>gl', ':Gclog -50<CR>')
vim.keymap.set('v', '<leader>gl', ":'<,'>Gclog -50<CR>")
vim.keymap.set('n', '<leader>gH', ':GBrowse<CR>')
vim.keymap.set('n', '<leader>gh', ':.GBrowse<CR>')
vim.keymap.set('v', '<leader>gh', ":'<,'>GBrowse<cr>")

-- Coc settings
vim.g.coc_global_extensions = {
	'coc-css',
	'coc-blade',
	'coc-docker',
	'coc-eslint',
	'coc-git',
	'coc-go',
	'coc-html',
	'coc-java',
	'coc-json',
	'coc-lists',
	'coc-sumneko-lua',
	'coc-markdownlint',
	'coc-markdown-preview-enhanced',
	'coc-phpls',
	'coc-php-cs-fixer',
	'coc-sh',
	'coc-snippets',
	'coc-sql',
	'coc-tsserver',
	'coc-vimlsp',
	'coc-xml',
	'coc-yaml',
	'@yaegassy/coc-ansible',
	'@yaegassy/coc-tailwindcss3',
	'@yaegassy/coc-phpstan',
}
-- 'coc-spell-checker',
-- 'coc-jsonc',
vim.opt.shortmess:append('c')

-- Coc lsp mappings
vim.api.nvim_create_user_command('Fold', "call CocAction('fold', <f-args>)", { nargs = '?' })
vim.keymap.set('n', '[e', '<Plug>(coc-diagnostic-prev)', { silent = true })
vim.keymap.set('n', ']e', '<Plug>(coc-diagnostic-next)', { silent = true })
vim.keymap.set('n', '<leader>e', ':CocList diagnostics<cr>')
vim.keymap.set('n', 'gd', '<Plug>(coc-definition)', { silent = true })
vim.keymap.set('n', 'gy', '<Plug>(coc-type-definition)', { silent = true })
vim.keymap.set('n', 'gi', '<Plug>(coc-implementation)', { silent = true })
vim.keymap.set('n', 'gr', '<Plug>(coc-references)', { silent = true })
vim.keymap.set({ 'x', 'o' }, 'if', '<Plug>(coc-funcobj-i)')
vim.keymap.set({ 'x', 'o' }, 'af', '<Plug>(coc-funcobj-a)')
vim.keymap.set({ 'x', 'o' }, 'ic', '<Plug>(coc-classobj-i)')
vim.keymap.set({ 'x', 'o' }, 'ac', '<Plug>(coc-classobj-a)')
vim.keymap.set({ 'n', 'x' }, '<C-s>', '<Plug>(coc-range-select)', { silent = true })
vim.keymap.set('n', '<leader>b', ':CocList outline<cr>')
vim.keymap.set('n', '<c-p>', ':CocList symbols<cr>')

-- Coc refactoring mappings
vim.api.nvim_create_user_command('Format', "call CocAction('format')", {})
vim.api.nvim_create_user_command('OR', "call CocActionAsync('runCommand', 'editor.action.organizeImport')", {})
vim.keymap.set('n', '<leader>rn', '<Plug>(coc-rename)')
vim.keymap.set('x', '<c-f>', ' <Plug>(coc-format-selected)')
vim.keymap.set('n', '<c-f>', '<Plug>(coc-format)')
vim.keymap.set('x', '<leader>a', ' <Plug>(coc-codeaction-selected)')
vim.keymap.set('n', '<leader>a', ' <Plug>(coc-codeaction-selected)')
vim.keymap.set('n', '<leader>ac', ' <Plug>(coc-codeaction)')
vim.keymap.set('n', '<leader>qf', ' <Plug>(coc-fix-current)')
vim.keymap.set('n', '<leader>cl', ' <Plug>(coc-codelens-action)')

-- Coc git mappings
vim.keymap.set('n', '[g', '<Plug>(coc-git-prevchunk)')
vim.keymap.set('n', ']g', '<Plug>(coc-git-nextchunk)')
vim.keymap.set('n', '[m', '<Plug>(coc-git-prevconflict)')
vim.keymap.set('n', ']m', '<Plug>(coc-git-nextconflict)')
vim.keymap.set('n', 'gs', '<Plug>(coc-git-chunkinfo)')
vim.keymap.set('n', 'gc', '<Plug>(coc-git-commit)')
vim.keymap.set({ 'o', 'x' }, 'ig', '<Plug>(coc-git-chunk-inner)')
vim.keymap.set({ 'o', 'x' }, 'ag', '<Plug>(coc-git-chunk-outer)')
vim.keymap.set('n', '<leader>ga', ':CocCommand git.chunkStage<cr>')
vim.keymap.set('n', '<leader>gx', ':CocCommand git.chunkUndo<cr>')
vim.keymap.set('n', '<leader>gf', ':CocCommand git.foldUnchanged<cr>')

-- Coc hover highlighting
vim.api.nvim_create_augroup('CocGroup', {})
vim.api.nvim_create_autocmd('CursorHold', {
	group = 'CocGroup',
	command = "silent call CocActionAsync('highlight')",
	desc = 'Highlight symbol under cursor on CursorHold',
})

-- Coc floating window mappings
vim.keymap.set('n', 'K', ':call CocActionAsync("doHover")<CR>', { silent = true })
vim.keymap.set('v', 'K', ':<C-U>call CocActionAsync("doHover")<CR>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<C-j>', 'coc#float#has_scroll() ? coc#float#scroll(1) : "\\<C-j>"',
	{ silent = true, nowait = true, expr = true })
vim.keymap.set('i', '<C-j>', 'coc#float#has_scroll() ? "\\<c-r>=coc#float#scroll(1)\\<cr>" : "\\<C-j>"',
	{ silent = true, nowait = true, expr = true })
vim.keymap.set({ 'n', 'v' }, '<C-k>', 'coc#float#has_scroll() ? coc#float#scroll(0) : "\\<C-k>"',
	{ silent = true, nowait = true, expr = true })
vim.keymap.set('i', '<C-k>', 'coc#float#has_scroll() ? "\\<c-r>=coc#float#scroll(0)\\<cr>" : "\\<C-k>"',
	{ silent = true, nowait = true, expr = true })

-- Coc Autocomplete mappings
local function previous_char_is_whitespace()
	local col = vim.fn.col('.') - 1
	return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s')
end
local function replace_termcodes(str)
	return vim.api.nvim_replace_termcodes(str, true, false, true)
end
local function do_snippet_jump()
	return replace_termcodes("<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])<CR>")
end
function _G.tab()
	if vim.fn['coc#pum#visible']() == 1 then
		return vim.fn['coc#pum#next'](1)
	elseif vim.fn.pumvisible() == 1 then
		return replace_termcodes('<C-n>')
	elseif vim.fn['coc#jumpable']() then
		return do_snippet_jump()
	elseif previous_char_is_whitespace() then
		return replace_termcodes('<Tab>')
	else
		return vim.fn['coc#refresh']()
	end
end

function _G.shift_tab()
	if vim.fn['coc#pum#visible']() == 1 then
		return vim.fn['coc#pum#prev'](1)
	elseif vim.fn.pumvisible() == 1 then
		return replace_termcodes('<C-p>')
		-- TODO add support for coc#jumpable
	else
		return replace_termcodes('<C-h>')
	end
end

function _G.enter()
	if vim.fn['coc#pum#visible']() == 1 then
		return vim.fn['coc#_select_confirm']()
	elseif vim.fn.pumvisible() == 1 then
		return replace_termcodes('<C-y>')
	elseif vim.fn['coc#expandableOrJumpable']() == 1 then
		return do_snippet_jump()
	else
		return replace_termcodes('<C-g>u<CR><c-r>=coc#on_enter()<CR>')
	end
end

function _G.ctrl_space()
	if vim.fn['coc#pum#visible']() == 1 then
		return vim.fn['coc#pum#cancel']()
	else
		return vim.fn['coc#refresh']()
	end
end

vim.keymap.set('i', '<TAB>', 'v:lua.tab()', { silent = true, expr = true })
vim.keymap.set('i', '<S-TAB>', 'v:lua.shift_tab()', { silent = true, expr = true })
vim.keymap.set('i', '<C-Space>', 'v:lua.ctrl_space()', { silent = true, expr = true })
vim.keymap.set('i', '<CR>', 'v:lua.enter()', { silent = true, expr = true })

-- Copilot settings
vim.g.copilot_no_tab_map = true
vim.keymap.set('i', '<C-Enter>', 'copilot#Accept("")',
	{ noremap = true, silent = true, expr = true, replace_keycodes = false })

-- airline settings
vim.g.airline_powerline_fonts = 1
vim.g['airline#extensions#tabline#enabled'] = 1

-- snippets settings
vim.g.ultisnips_php_scalar_types = 1

-- yoink settings
vim.keymap.set('n', '<leader>]', '<plug>(YoinkPostPasteSwapBack)')
vim.keymap.set('n', '<leader>[', '<plug>(YoinkPostPasteSwapForward)')
vim.keymap.set('n', 'p', '<plug>(YoinkPaste_p)')
vim.keymap.set('n', 'P', '<plug>(YoinkPaste_P)')
vim.keymap.set('n', 'gp', '<plug>(YoinkPaste_gp)')
vim.keymap.set('n', 'gP', '<plug>(YoinkPaste_gP)')
vim.g.yoinkMaxItems = 100
vim.g.yoinkIncludeDeleteOperations = 1
vim.g.yoinkSavePersistently = 1
vim.g.yoinkAutoFormatPaste = 1
vim.g.yoinkSwapClampAtEnds = 0

-- commentary settings
vim.keymap.set('x', '<leader>c', ' <Plug>Commentary')
vim.keymap.set('n', '<leader>c', ' <Plug>Commentary')
vim.keymap.set('o', '<leader>c', ' <Plug>Commentary')
vim.keymap.set('n', '<leader>cc', '<Plug>CommentaryLine')
vim.keymap.set('n', '<leader>cu', '<Plug>Commentary<Plug>Commentary')

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

require 'nvim-treesitter.configs'.setup {
	auto_install = true,
	highlight = {
		enable = true,
	},
	indent = {
		enable = true,
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = 'gnn',
			scope_incremental = 'grc',
			node_incremental = ';',
			node_decremental = ',',
		},
	},
	textobjects = {
		select = {
			enable = true,
			lookahead = true,
			keymaps = {
				['af'] = '@function.outer',
				['if'] = '@function.inner',
				['ac'] = '@class.outer',
				['ic'] = '@class.inner',
				['ao'] = '@loop.outer',
				['io'] = '@loop.inner',
				['as'] = '@scope',
				['al'] = '@statement.outer'
			},
		},
		move = {
			enable = true,
			set_jumps = false,
			goto_next_start = {
				[']f'] = '@function.outer',
				[']c'] = '@class.outer',
				[']o'] = '@loop.outer',
				[']s'] = '@scope',
			},
			goto_next_end = {
				[']F'] = '@function.outer',
				[']C'] = '@class.outer',
				[']O'] = '@loop.outer',
				['[s'] = '@scope',
			},
			goto_previous_start = {
				['[f'] = '@function.outer',
				['[c'] = '@class.outer',
				['[o'] = '@loop.outer',
			},
			goto_previous_end = {
				['[F'] = '@function.outer',
				['[C'] = '@class.outer',
				['[O'] = '@loop.outer',
			},
		},
	},
}

require 'toggleterm'.setup {
	open_mapping = [[<c-\>]],
	insert_mappings = true,
	terminal_mappings = true,
}

require 'neotest'.setup({
	adapters = {
		require 'neotest-pest' ({
			pest_cmd = function()
				return 'sail pest'
			end
		}),
	}
})

vim.keymap.set('n', '<C-Enter>', function() require 'neotest'.run.run(vim.fn.expand('%')) end)
--To test a directory run lua require'neotest'.run.run("path/to/directory")
--To test the full test suite run lua require'neotest'.run.run({ suite = true })
