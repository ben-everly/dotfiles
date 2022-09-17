let mapleader = " "

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
nmap <leader>n :NERDTreeToggle<cr>
nmap <leader>N :NERDTreeFind<cr>

Plug 'tpope/vim-fugitive'
nmap <leader>gp :Git pull <bar> :Gpush<cr>
nmap <leader>gf :Git fetch<cr>
vmap <leader>gl :'<,'>Gclog -50<cr>

Plug 'tpope/vim-rhubarb'
nmap <leader>gH :GBrowse<cr>
nmap <leader>gh :.GBrowse<cr>
vmap <leader>gh :'<,'>GBrowse<cr>

Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}
let g:coc_global_extensions = [
	\ 'coc-snippets',
	\ 'coc-lists',
	\ 'coc-git',
	\ 'coc-phpls',
	\ 'coc-php-cs-fixer',
	\ 'coc-go',
	\ 'coc-tsserver',
	\ 'coc-eslint',
	\ 'coc-sql',
	\ 'coc-json',
	\ 'coc-yaml',
	\ 'coc-xml',
	\ 'coc-html',
	\ 'coc-css',
	\ 'coc-sh',
	\ 'coc-docker',
	\ 'coc-vimlsp',
	\ 'coc-lua',
	\ 'coc-markdownlint',
	\ 'coc-markdown-preview-enhanced',
	\ ]
	" \ 'coc-spell-checker',
	" \ 'coc-phpstan',
	" \ '@yeagassy/coc-tailwindcss3',
	" \ '@yeagassy/coc-ansible',
set shortmess+=c
nmap <silent> [e <Plug>(coc-diagnostic-prev)
nmap <silent> ]e <Plug>(coc-diagnostic-next)
nmap <leader>e :CocList diagnostics<cr>
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
imap <silent><expr> <TAB>
			\ coc#pum#visible() ? coc#pum#next(1):
			\ pumvisible() ? "\<C-n>" :
			\ coc#jumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>":
			\ PreviousCharIsWhitespace() ? "\<TAB>" :
			\ coc#refresh()
imap <expr><S-TAB>
			\ coc#pum#visible() ? coc#pum#prev(1):
			\ pumvisible() ? "\<C-p>":
			\ "\<C-h>"
function! PreviousCharIsWhitespace() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction
if has('nvim')
	inoremap <silent><expr> <c-space> coc#refresh()
else
	inoremap <silent><expr> <c-@> coc#refresh()
endif
inoremap <silent><expr> <cr>
			\ coc#pum#visible() ? coc#_select_confirm():
			\ pumvisible() ? coc#_select_confirm():
			\ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
			\ "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
nnoremap <silent> K :call ShowDocumentation()<CR>
function! ShowDocumentation()
	if CocAction('hasProvider', 'hover')
		call CocActionAsync('doHover')
	else
		call feedkeys('K', 'in')
	endif
endfunction
autocmd CursorHold * silent call CocActionAsync('highlight')
nmap <leader>rn <Plug>(coc-rename)
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format)
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>ac  <Plug>(coc-codeaction)
nmap <leader>qf  <Plug>(coc-fix-current)
nmap <leader>cl  <Plug>(coc-codelens-action)
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)
if has("nvim-0.5.0") || has("patch-8.1.1564")
	set signcolumn=number
else
	set signcolumn=yes
endif
if has('nvim-0.4.0') || has('patch-8.2.0750')
	nnoremap <silent><nowait><expr> <C-j> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
	nnoremap <silent><nowait><expr> <C-k> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
	inoremap <silent><nowait><expr> <C-j> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
	inoremap <silent><nowait><expr> <C-k> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
	vnoremap <silent><nowait><expr> <C-j> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
	vnoremap <silent><nowait><expr> <C-k> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)
command! -nargs=0 Format :call CocActionAsync('format')
command! -nargs=? Fold :call CocAction('fold', <f-args>)
command! -nargs=0 OR   :call CocActionAsync('runCommand', 'editor.action.organizeImport')
nmap <leader>b :CocList outline<cr>
nmap <c-p> :CocList symbols<cr>
nmap <leader>p :CocList gfiles<cr>
nmap [g <Plug>(coc-git-prevchunk)
nmap ]g <Plug>(coc-git-nextchunk)
nmap [c <Plug>(coc-git-prevconflict)
nmap ]c <Plug>(coc-git-nextconflict)
nmap gs <Plug>(coc-git-chunkinfo)
nmap gc <Plug>(coc-git-commit)
omap ig <Plug>(coc-git-chunk-inner)
xmap ig <Plug>(coc-git-chunk-inner)
omap ag <Plug>(coc-git-chunk-outer)
xmap ag <Plug>(coc-git-chunk-outer)
nmap <leader>gl :CocList commits<cr>
nmap <leader>gs :CocList gstatus<cr>
nmap <leader>gb :CocList branches<cr>
nmap <leader>ga :CocCommand git.chunkStage<cr>
nmap <leader>gx :CocCommand git.chunkUndo<cr>
nmap <leader>gf :CocCommand git.foldUnchanged<cr>

Plug 'vim-airline/vim-airline'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

Plug 'ludovicchabant/vim-gutentags'
let g:gutentags_cache_dir = '~/.vim/gutentags'
let g:gutentags_ctags_exclude = ['*.css', '*.html', '*.js', '*.json', '*.xml', '*.phar', '*.ini', '*.rst', '*.md', '*vendor/*/test*', '*vendor/*/Test*', '*vendor/*/fixture*', '*vendor/*/Fixture*', '*var/cache*', '*var/log*']

Plug 'tobyS/pdv'
let g:pdv_template_dir=$HOME . "/.vim/plug/pdv/templates_snip"
nmap /** :call pdv#DocumentWithSnip()<cr>

Plug 'ben-everly/vim-snippets'
let g:ultisnips_php_scalar_types=1

Plug 'svermeulen/vim-yoink'
nmap <leader>] <plug>(YoinkPostPasteSwapBack)
nmap <leader>[ <plug>(YoinkPostPasteSwapForward)
nmap p <plug>(YoinkPaste_p)
nmap P <plug>(YoinkPaste_P)
nmap gp <plug>(YoinkPaste_gp)
nmap gP <plug>(YoinkPaste_gP)
let g:yoinkMaxItems=100
let g:yoinkIncludeDeleteOperations=1
let g:yoinkSavePersistently=1
let g:yoinkAutoFormatPaste=1
let g:yoinkSwapClampAtEnds=0

Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-treesitter/nvim-treesitter-context'

Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'

Plug 'tobyS/vmustache'
Plug 'tpope/vim-dadbod', { 'for': ['sql', 'mysql'] }
Plug 'jiangmiao/auto-pairs'
Plug 'romainl/vim-qf'
Plug 'tpope/vim-commentary'
xmap <leader>c  <Plug>Commentary
nmap <leader>c  <Plug>Commentary
omap <leader>c  <Plug>Commentary
nmap <leader>cc <Plug>CommentaryLine
nmap <leader>cu <Plug>Commentary<Plug>Commentary

Plug 'tpope/vim-surround'

call plug#end()

lua << EOF
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
}
EOF
nmap <leader>d<cr> :lua require'dap'.continue()<CR>
nmap <leader>db :lua require'dap'.toggle_breakpoint()<CR>
nmap <leader>dj :lua require'dap'.step_over()<CR>
nmap <leader>dl :lua require'dap'.step_into()<CR>
nmap <leader>dh :lua require'dap'.step_out()<CR>
nmap <leader>dn :lua require'dapui'.toggle()<CR>
nmap <M-k> <Cmd>lua require("dapui").eval()<CR>
vmap <M-k> <Cmd>lua require("dapui").eval()<CR>

colorscheme gruvbox
set number relativenumber
set scrolloff=3
set lazyredraw
set autoread
set hidden
set cf
set nosol
set cursorline
set ignorecase
set shell=zsh
set tabstop=4
set shiftwidth=4
set expandtab
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
nnoremap ; :
cmap w!! w !sudo tee % >/dev/null

runtime vimrc.local
