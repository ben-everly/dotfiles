vim.cmd([[
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
]])
vim.g.mapleader = " "

vim.cmd([[
if empty(glob('~/.vim/autoload/plug.vim'))
	silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
	\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

augroup plug
	au!
	autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
		\| PlugInstall --sync | source $MYVIMRC
		\| endif
augroup end

call plug#begin('~/.vim/plug')
Plug 'tpope/vim-sensible'
Plug 'morhetz/gruvbox'
Plug 'preservim/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] }
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'vim-airline/vim-airline'
Plug 'ludovicchabant/vim-gutentags'
Plug 'ben-everly/vim-snippets'
Plug 'svermeulen/vim-yoink'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-treesitter/nvim-treesitter-context'
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'
Plug 'tpope/vim-dadbod', { 'for': ['sql', 'mysql'] }
Plug 'jiangmiao/auto-pairs'
Plug 'romainl/vim-qf'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-sleuth'
Plug 'github/copilot.vim'
call plug#end()

]])

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
	'coc-snippets',
	'coc-lists',
	'coc-git',
	'coc-phpls',
	'coc-php-cs-fixer',
	'coc-go',
	'coc-tsserver',
	'coc-eslint',
	'coc-sql',
	'coc-json',
	'coc-yaml',
	'coc-xml',
	'coc-html',
	'coc-css',
	'coc-sh',
	'coc-docker',
	'coc-vimlsp',
	'coc-lua',
	'coc-markdownlint',
	'coc-markdown-preview-enhanced',
}
-- 'coc-spell-checker',
-- 'coc-phpstan',
-- 'coc-jsonc',
-- '@yeagassy/coc-tailwindcss3',
-- '@yeagassy/coc-ansible',
vim.opt.shortmess:append('c')

-- Coc lsp mappings
vim.api.nvim_create_user_command("Fold", "call CocAction('fold', <f-args>)", {nargs = '?'})
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
map('x', '<leader>f', ' <Plug>(coc-format-selected)')
map('n', '<leader>f', ' <Plug>(coc-format)')
map('x', '<leader>a', ' <Plug>(coc-codeaction-selected)')
map('n', '<leader>a', ' <Plug>(coc-codeaction-selected)')
map('n', '<leader>ac', ' <Plug>(coc-codeaction)')
map('n', '<leader>qf', ' <Plug>(coc-fix-current)')
map('n', '<leader>cl', ' <Plug>(coc-codelens-action)')

-- Coc git mappings
map('n', '<leader>p', ':CocList gfiles<cr>')
map('n', '[g', '<Plug>(coc-git-prevchunk)')
map('n', ']g', '<Plug>(coc-git-nextchunk)')
map('n', '[c', '<Plug>(coc-git-prevconflict)')
map('n', ']c', '<Plug>(coc-git-nextconflict)')
map('n', 'gs', '<Plug>(coc-git-chunkinfo)')
map('n', 'gc', '<Plug>(coc-git-commit)')
map({ 'o', 'x' }, 'ig', '<Plug>(coc-git-chunk-inner)')
map({ 'o', 'x' }, 'ag', '<Plug>(coc-git-chunk-outer)')
map('n', '<leader>gl', ':CocList commits<cr>')
map('n', '<leader>gs', ':CocList gstatus<cr>')
map('n', '<leader>gb', ':CocList branches<cr>')
map('n', '<leader>ga', ':CocCommand git.chunkStage<cr>')
map('n', '<leader>gx', ':CocCommand git.chunkUndo<cr>')
map('n', '<leader>gf', ':CocCommand git.foldUnchanged<cr>')

-- Coc hover highlighting
vim.api.nvim_create_autocmd("CursorHold", {
	pattern = "*",
	command = "silent call CocActionAsync('highlight')"
})

-- Coc floating window mappings
map('n', 'K', ':call CocActionAsync("doHover")<CR>', { silent = true })
map('v', 'K', ':<C-U>call CocActionAsync("doHover")<CR>', { silent = true })
map({ 'n', 'v' }, '<C-j>', 'coc#float#has_scroll() ? coc#float#scroll(1) : "\\<C-j>"', { silent = true, nowait = true, expr = true })
map('i', '<C-j>', 'coc#float#has_scroll() ? "\\<c-r>=coc#float#scroll(1)\\<cr>" : "\\<C-j>"', { silent = true, nowait = true, expr = true })
map({ 'n', 'v' }, '<C-k>', 'coc#float#has_scroll() ? coc#float#scroll(0) : "\\<C-k>"', { silent = true, nowait = true, expr = true })
map('i', '<C-k>', 'coc#float#has_scroll() ? "\\<c-r>=coc#float#scroll(0)\\<cr>" : "\\<C-k>"', { silent = true, nowait = true, expr = true })

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
	if vim.fn['coc#pum#visible']() == 1 then return vim.fn['coc#pum#next'](1)
	elseif vim.fn.pumvisible() == 1 then return replace_termcodes('<C-n>')
	elseif vim.fn['coc#jumpable']() then return do_snippet_jump()
	elseif previous_char_is_whitespace() then return replace_termcodes('<Tab>')
	else return vim.fn['coc#refresh']()
	end
end
function _G.shift_tab()
	if vim.fn['coc#pum#visible']() == 1 then return vim.fn['coc#pum#prev'](1)
	elseif vim.fn.pumvisible() == 1 then return replace_termcodes('<C-p>')
	-- TODO add support for coc#jumpable
	else return replace_termcodes('<C-h>')
	end
end
function _G.enter()
	if vim.fn['coc#pum#visible']() == 1 then return vim.fn['coc#_select_confirm']()
	elseif vim.fn.pumvisible() == 1 then return replace_termcodes('<C-y>')
	elseif vim.fn['coc#expandableOrJumpable']() == 1 then return do_snippet_jump()
	else return replace_termcodes('<C-g>u<CR><c-r>=coc#on_enter()<CR>')
	end
end
map('i', '<TAB>', 'v:lua.tab()', { silent = true, expr = true })
map('i', '<S-TAB>', 'v:lua.shift_tab()', { silent = true, expr = true })
map('i', '<C-Space>', 'coc#pum#visible() ? coc#pum#cancel(): coc#refresh()', { silent = true, expr = true })
map('i', '<CR>', 'v:lua.enter()', { silent = true, expr = true })

-- Copilot settings
vim.g.copilot_no_tab_map = true
map('i', '<C-Enter>', 'copilot#Accept("\\<CR>")', { silent = true, script = true, expr = true })

-- airline settings
vim.g.airline_powerline_fonts = 1
vim.g['airline#extensions#tabline#enabled'] = 1

-- gutentags settings
vim.g.gutentags_cache_dir = '~/.cache/gutentags'
vim.g.gutentags_ctags_exclude = { '*.css', '*.html', '*.js', '*.json', '*.xml', '*.phar', '*.ini', '*.rst', '*.md', '*vendor/*/test*', '*vendor/*/Test*', '*vendor/*/fixture*', '*vendor/*/Fixture*', '*var/cache*', '*var/log*' }

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

vim.cmd([[

xmap <leader>c  <Plug>Commentary
nmap <leader>c  <Plug>Commentary
omap <leader>c  <Plug>Commentary
nmap <leader>cc <Plug>CommentaryLine
nmap <leader>cu <Plug>Commentary<Plug>Commentary

call coc#config("intelephense.licenceKey", $INTELEPHENSE_KEY)

nmap <leader>d<cr> :lua require'dap'.continue()<CR>
nmap <leader>db :lua require'dap'.toggle_breakpoint()<CR>
nmap <leader>dj :lua require'dap'.step_over()<CR>
nmap <leader>dl :lua require'dap'.step_into()<CR>
nmap <leader>dh :lua require'dap'.step_out()<CR>
nmap <leader>dn :lua require'dapui'.toggle()<CR>
nmap <M-k> <Cmd>lua require("dapui").eval()<CR>
vmap <M-k> <Cmd>lua require("dapui").eval()<CR>

colorscheme gruvbox
set signcolumn=auto:1-9
set number relativenumber
set scrolloff=3
set lazyredraw
set autoread
set hidden
set completefunc
set nostartofline
set cursorline
set ignorecase
set shell=zsh
set nowrap
set clipboard^=unnamed,unnamedplus
" show a · for trailing whitespace and a | for tabs
set list
set listchars=tab:\|\ ,trail:·
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set cmdheight=2
set updatetime=300
set inccommand=nosplit
let g:vimsyn_embed = 'l'

augroup folding
au!
autocmd Syntax * normal zR
augroup end

xnoremap il g_o^
onoremap il :normal vil<CR>
xnoremap al $o^
onoremap al :normal val<CR>

nmap <leader>w :w!<cr>
nmap <leader>q :bd<cr>
nmap <leader>l :ls<cr>
nmap <leader><C-t> :enew<cr>
nmap <leader><C-w> :bp\|bd #<cr>
nmap <leader>. :bnext<cr>
nmap <leader>, :bprevious<cr>
nmap <c-w><s-j> :res -10<cr>
nmap <c-w><s-k> :res +10<cr>
nmap <c-w><s-l> :vert res -10<cr>
nmap <c-w><s-h> :vert res +10<cr>
vmap // y/\V<c-r>=escape(@",'/\')<cr><cr>
cmap w!! w !sudo tee % >/dev/null

runtime vimrc.local
]])
local dap, dapui = require('dap'), require('dapui')
dap.adapters.php = {
	type = 'executable',
	command = 'node',
	args = { '/home/beneverly/.ansible/pull/work-XPS-15-9520/tmp/php-debug-client/out/phpDebug.js' }
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

require'nvim-treesitter.configs'.setup {
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
			node_incremental = "grn",
			scope_incremental = "grc",
			node_decremental = "grm",
		},
	},
}
