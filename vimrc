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
nmap <leader>gs :Git<cr>
nmap <leader>gb :Git blame<cr>
nmap <leader>gd :Git diff<cr>
nmap <leader>gp :Git pull <bar> :Gpush<cr>
nmap <leader>gf :Git fetch<cr>
nmap <leader>gl :Gclog -50<cr>
vmap <leader>gl :'<,'>Gclog -50<cr>

Plug 'tpope/vim-rhubarb'
nmap <leader>gH :GBrowse<cr>
nmap <leader>gh :.GBrowse<cr>
vmap <leader>gh :'<,'>GBrowse<cr>

Plug 'neoclide/coc.nvim', {'branch': 'release'}
let g:coc_global_extensions = ['coc-phpls', 'coc-tsserver', 'coc-snippets', 'coc-php-cs-fixer', 'coc-lists']
set shortmess+=c
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
inoremap <silent><expr> <TAB>
			\ pumvisible() ? "\<C-n>" :
			\ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
			\ CheckBackspace() ? "\<TAB>" :
			\ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! CheckBackspace() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction
inoremap <silent><expr> <c-space> coc#refresh()
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
nmap <leader>f  <Plug>(coc-format-selected)
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
nmap <leader>p :CocList files<cr>

Plug 'vim-airline/vim-airline'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#tagbar#flags = 'f'

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

Plug 'vim-vdebug/vdebug'
let g:vdebug_options = {
	\ 'break_on_open'      : 0,
	\ 'continuous_mode'    : 1,
	\ 'path_maps'          : { "/var/www/app": system('git rev-parse --show-toplevel 2> /dev/null')[:-2] },
	\ 'sign_breakpoint'    : '▶',
	\ 'watch_window_style' : 'compact',
\}
let g:vdebug_keymap = {
	\ 'run'               : "<leader>d<cr>",
	\ 'run_to_cursor'     : "<leader>dc",
	\ "step_over"         : "<leader>dj",
	\ "step_into"         : "<leader>d]",
	\ "step_out"          : "<leader>d[",
	\ "close"             : "<leader>dq",
	\ "set_breakpoint"    : "<leader>db",
	\ "get_context"       : "<F11>",
	\ "eval_under_cursor" : "<leader>e",
	\ "eval_visual"       : "<leader>ve",
\}
augroup vdebug
	au!
	au ColorScheme *
		\ highlight! clear DbgCurrentLine |
		\ highlight! clear DbgBreakptLine |
		\ highlight! link DbgBreakptSign GruvboxRedSign |
		\ highlight! link DbgCurrentSign GruvboxGreenSign |
augroup end

Plug 'tobyS/vmustache'
Plug 'sheerun/vim-polyglot'
Plug 'rayburgemeestre/phpfolding.vim', { 'for': ['php'] }
Plug 'StanAngeloff/php.vim', { 'for': ['php'] }
Plug 'tpope/vim-dadbod', { 'for': ['sql', 'mysql'] }
Plug 'jiangmiao/auto-pairs'
Plug 'romainl/vim-qf'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'

call plug#end()

colorscheme gruvbox
set number
set scrolloff=3
set lazyredraw
set autoread
set hidden
set cf
set nosol
set cursorline
set ignorecase
set shellcmdflag=-ic
set tabstop=4
set nowrap
set clipboard^=unnamed,unnamedplus
" show a · for trailing whitespace and a | for tabs
set list
set listchars=tab:\|\ ,trail:·
set foldmethod=syntax
set cmdheight=2
set updatetime=300

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
