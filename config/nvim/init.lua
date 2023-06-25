require 'packer-config'

vim.g.mapleader = " "

local map = vim.keymap.set

-- NERDTree settings
map('n', '<leader>n', ':NERDTreeToggle<CR>')
map('n', '<leader>N', ':NERDTreeFind<CR>')

-- Fugitive settings
map('n', '<leader>gp', ':Git push<CR>')
map('n', '<leader>gf', ':Git fetch<CR>')
map('n', '<leader>gl', ":Gclog -50<CR>")
map('v', '<leader>gl', ":'<,'>Gclog -50<CR>")
map('n', '<leader>gH', ':GBrowse<CR>')
map('n', '<leader>gh', ':.GBrowse<CR>')
map('v', '<leader>gh', ":'<,'>GBrowse<cr>")

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
vim.fn['coc#config']("intelephense.licenceKey", vim.env.INTELEPHENSE_KEY)
vim.api.nvim_create_user_command("Fold", "call CocAction('fold', <f-args>)", { nargs = '?' })
map('n', '[e', '<Plug>(coc-diagnostic-prev)', { silent = true })
map('n', ']e', '<Plug>(coc-diagnostic-next)', { silent = true })
map('n', '<leader>e', ':CocList diagnostics<cr>')
map('n', 'gd', '<Plug>(coc-definition)', { silent = true })
map('n', 'gy', '<Plug>(coc-type-definition)', { silent = true })
map('n', 'gi', '<Plug>(coc-implementation)', { silent = true })
map('n', 'gr', '<Plug>(coc-references)', { silent = true })
map({ 'x', 'o' }, 'if', '<Plug>(coc-funcobj-i)')
map({ 'x', 'o' }, 'af', '<Plug>(coc-funcobj-a)')
map({ 'x', 'o' }, 'ic', '<Plug>(coc-classobj-i)')
map({ 'x', 'o' }, 'ac', '<Plug>(coc-classobj-a)')
map({ 'n', 'x' }, '<C-s>', '<Plug>(coc-range-select)', { silent = true })
map('n', '<leader>b', ':CocList outline<cr>')
map('n', '<c-p>', ':CocList symbols<cr>')

-- Coc refactoring mappings
vim.api.nvim_create_user_command("Format", "call CocAction('format')", {})
vim.api.nvim_create_user_command("OR", "call CocActionAsync('runCommand', 'editor.action.organizeImport')", {})
map('n', '<leader>rn', '<Plug>(coc-rename)')
map('x', '<c-f>', ' <Plug>(coc-format-selected)')
map('n', '<c-f>', '<Plug>(coc-format)')
map('x', '<leader>a', ' <Plug>(coc-codeaction-selected)')
map('n', '<leader>a', ' <Plug>(coc-codeaction-selected)')
map('n', '<leader>ac', ' <Plug>(coc-codeaction)')
map('n', '<leader>qf', ' <Plug>(coc-fix-current)')
map('n', '<leader>cl', ' <Plug>(coc-codelens-action)')

-- Coc git mappings
map('n', '[g', '<Plug>(coc-git-prevchunk)')
map('n', ']g', '<Plug>(coc-git-nextchunk)')
map('n', '[m', '<Plug>(coc-git-prevconflict)')
map('n', ']m', '<Plug>(coc-git-nextconflict)')
map('n', 'gs', '<Plug>(coc-git-chunkinfo)')
map('n', 'gc', '<Plug>(coc-git-commit)')
map({ 'o', 'x' }, 'ig', '<Plug>(coc-git-chunk-inner)')
map({ 'o', 'x' }, 'ag', '<Plug>(coc-git-chunk-outer)')
map('n', '<leader>ga', ':CocCommand git.chunkStage<cr>')
map('n', '<leader>gx', ':CocCommand git.chunkUndo<cr>')
map('n', '<leader>gf', ':CocCommand git.foldUnchanged<cr>')

-- Coc hover highlighting
vim.api.nvim_create_augroup("CocGroup", {})
vim.api.nvim_create_autocmd("CursorHold", {
	group = "CocGroup",
	command = "silent call CocActionAsync('highlight')",
	desc = "Highlight symbol under cursor on CursorHold",
})

-- Coc floating window mappings
map('n', 'K', ':call CocActionAsync("doHover")<CR>', { silent = true })
map('v', 'K', ':<C-U>call CocActionAsync("doHover")<CR>', { silent = true })
map({ 'n', 'v' }, '<C-j>', 'coc#float#has_scroll() ? coc#float#scroll(1) : "\\<C-j>"',
	{ silent = true, nowait = true, expr = true })
map('i', '<C-j>', 'coc#float#has_scroll() ? "\\<c-r>=coc#float#scroll(1)\\<cr>" : "\\<C-j>"',
	{ silent = true, nowait = true, expr = true })
map({ 'n', 'v' }, '<C-k>', 'coc#float#has_scroll() ? coc#float#scroll(0) : "\\<C-k>"',
	{ silent = true, nowait = true, expr = true })
map('i', '<C-k>', 'coc#float#has_scroll() ? "\\<c-r>=coc#float#scroll(0)\\<cr>" : "\\<C-k>"',
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

map('i', '<TAB>', 'v:lua.tab()', { silent = true, expr = true })
map('i', '<S-TAB>', 'v:lua.shift_tab()', { silent = true, expr = true })
map('i', '<C-Space>', 'v:lua.ctrl_space()', { silent = true, expr = true })
map('i', '<CR>', 'v:lua.enter()', { silent = true, expr = true })

-- Copilot settings
vim.g.copilot_no_tab_map = true
map('i', '<C-Enter>', 'copilot#Accept("")', { noremap = true, silent = true, expr = true, replace_keycodes = false })

-- airline settings
vim.g.airline_powerline_fonts = 1
vim.g['airline#extensions#tabline#enabled'] = 1

-- gutentags settings
vim.g.gutentags_cache_dir = '~/.cache/gutentags'
vim.g.gutentags_ctags_exclude = {
	'*.css',
	'*.html',
	'*.js',
	'*.json',
	'*.xml',
	'*.phar',
	'*.ini',
	'*.rst',
	'*.md',
	'*vendor/*/test*',
	'*vendor/*/Test*',
	'*vendor/*/fixture*',
	'*vendor/*/Fixture*',
	'*var/cache*',
	'*var/log*'
}

-- snippets settings
vim.g.ultisnips_php_scalar_types = 1

-- yoink settings
map('n', '<leader>]', '<plug>(YoinkPostPasteSwapBack)')
map('n', '<leader>[', '<plug>(YoinkPostPasteSwapForward)')
map('n', 'p', '<plug>(YoinkPaste_p)')
map('n', 'P', '<plug>(YoinkPaste_P)')
map('n', 'gp', '<plug>(YoinkPaste_gp)')
map('n', 'gP', '<plug>(YoinkPaste_gP)')
vim.g.yoinkMaxItems = 100
vim.g.yoinkIncludeDeleteOperations = 1
vim.g.yoinkSavePersistently = 1
vim.g.yoinkAutoFormatPaste = 1
vim.g.yoinkSwapClampAtEnds = 0

-- commentary settings
map('x', '<leader>c', ' <Plug>Commentary')
map('n', '<leader>c', ' <Plug>Commentary')
map('o', '<leader>c', ' <Plug>Commentary')
map('n', '<leader>cc', '<Plug>CommentaryLine')
map('n', '<leader>cu', '<Plug>Commentary<Plug>Commentary')

-- telescope settings
local builtin = require('telescope.builtin')
map('n', '<leader>ff', builtin.find_files)
map('n', '<leader>fF', builtin.git_files)
map('n', '<leader>fg', builtin.live_grep)
map('n', '<leader>fb', builtin.buffers)
map('n', '<leader>fh', builtin.help_tags)
map('n', '<leader>fj', builtin.jumplist)
map('n', '<leader>fr', builtin.registers)
map('n', '<leader>f/', builtin.search_history)
map('n', '<leader>gbl', builtin.git_branches)
map('n', '<leader>glg', builtin.git_commits)
map('n', '<leader>glb', builtin.git_bcommits)
map('n', '<leader>gws', builtin.git_status)
map('n', '<leader>gsl', builtin.git_stash)
map('n', '<leader>b', builtin.treesitter)
map('n', '<leader>fs', builtin.lsp_workspace_symbols)
map('n', '<space>ft', require 'telescope'.extensions.file_browser.file_browser, { noremap = true })
require 'telescope'.setup {
	defaults = {
		mappings = {
			i = {
				['<C-j>'] = 'move_selection_next',
				['<C-k>'] = 'move_selection_previous',
			},
		},
	},
}

-- general settings
map('n', '<leader>w', ':w!<cr>')
map('n', '<leader>q', ':bd<cr>')
map('n', '<leader>l', ':ls<cr>')
map('n', '<leader><C-t>', ':enew<cr>')
map('n', '<leader><C-w>', ':bp|bd #<cr>')
map('n', '<leader>.', ':bnext<cr>')
map('n', '<leader>,', ':bprevious<cr>')
map('n', '<c-w><s-j>', ':res -10<cr>')
map('n', '<c-w><s-k>', ':res +10<cr>')
map('n', '<c-w><s-l>', ':vert res -10<cr>')
map('n', '<c-w><s-h>', ':vert res +10<cr>')
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
vim.cmd('colorscheme gruvbox')

local folding_group = vim.api.nvim_create_augroup('folding', { clear = true })
vim.api.nvim_create_autocmd('Syntax', { pattern = '*', group = folding_group, command = 'normal zR' })

if vim.fn.filereadable(vim.env.HOME .. '/.vim/vimrc.local') ~= 0
then
	vim.cmd([[ source ~/.vim/vimrc.local ]])
end

-- dap settings
map('n', '<leader>d<cr>', ":lua require'dap'.continue()<CR>")
map('n', '<leader>dq', ":lua require'dap'.terminate()<CR>:lua require'dap'.close()<CR>")
map('n', '<leader>dr', ":lua require'dap'.restart()<CR>")
map('n', '<leader>db', ":lua require'dap'.toggle_breakpoint()<CR>")
map('n', '<leader>dj', ":lua require'dap'.step_over()<CR>")
map('n', '<leader>dl', ":lua require'dap'.step_into()<CR>")
map('n', '<leader>dh', ":lua require'dap'.step_out()<CR>")
map('n', '<leader>dn', ":lua require'dapui'.toggle()<CR>")
map('n', '<M-k>', "<Cmd>lua require('dapui').eval()<CR>")
map('v', '<M-k>', "<Cmd>lua require('dapui').eval()<CR>")

local dap, dapui = require('dap'), require('dapui')
dap.adapters.php = {
	type = 'executable',
	command = 'node',
	args = { '/home/beneverly/.local/lib/php-debug-client/out/phpDebug.js' }
}

dap.configurations.php = {
	{
		type = 'php',
		request = 'launch',
		name = 'Listen for Xdebug',
		port = 9000,
		log = true,
		pathMappings = {
			['/var/www/app/'] = '${workspaceFolder}'
		}
	}
}

dapui.setup()
dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
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
			init_selection = "gnn",
			scope_incremental = "grc",
			node_incremental = ";",
			node_decremental = ",",
		},
	},
	textobjects = {
		select = {
			enable = true,
			lookahead = true,
			keymaps = {
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
				["ao"] = "@loop.outer",
				["io"] = "@loop.inner",
				["as"] = "@scope",
				["al"] = "@statement.outer"
			},
		},
		move = {
			enable = true,
			set_jumps = false,
			goto_next_start = {
				["]f"] = "@function.outer",
				["]c"] = "@class.outer",
				["]o"] = "@loop.outer",
				["]s"] = "@scope",
			},
			goto_next_end = {
				["]F"] = "@function.outer",
				["]C"] = "@class.outer",
				["]O"] = "@loop.outer",
				["[s"] = "@scope",
			},
			goto_previous_start = {
				["[f"] = "@function.outer",
				["[c"] = "@class.outer",
				["[o"] = "@loop.outer",
			},
			goto_previous_end = {
				["[F"] = "@function.outer",
				["[C"] = "@class.outer",
				["[O"] = "@loop.outer",
			},
		},
	},
}
local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"
vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)
vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f)
vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F)
vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t)
vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T)

require 'toggleterm'.setup {
	open_mapping = [[<c-\>]],
	insert_mappings = true,
	terminal_mappings = true,
}

map('n', '<C-Enter>', ":lua require('neotest').run.run(vim.fn.expand('%'))<CR>")
--To test a directory run lua require('neotest').run.run("path/to/directory")
--To test the full test suite run lua require('neotest').run.run({ suite = true })
