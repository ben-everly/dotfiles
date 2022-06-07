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
Plug 'neomake/neomake'

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

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
let g:deoplete#enable_at_startup = 1
augroup deoplete
	au!
	au VimEnter * call deoplete#custom#option('sources', {
			\ '_': ['omni', 'around', 'buffer', 'tag', 'member', 'file', 'snippet'],
			\ 'php': ['phpactor',  'omni', 'around', 'buffer', 'member', 'file', 'snippet']
			\})
augroup end
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"


Plug 'phpactor/phpactor', { 'for': 'php', 'dir': '~/.vim/plug/phpactor', 'do': 'composer -qn update && composer -qn install' }
augroup phpactor
	au!
	au User phpactor nmap <leader>v :call phpactor#GotoDefinition()<cr>
	au User phpactor nmap <leader>x :call phpactor#ContextMenu()<cr>
	au User phpactor vmap <leader>cf :call phpactor#ExtractMethod()<cr>
	au User phpactor nmap <leader>cv :call phpactor#ExtractExpression(v:false)<cr>
	au User phpactor vmap <leader>cv :call phpactor#ExtractExpression(v:true)<cr>
augroup end

Plug 'kristijanhusak/deoplete-phpactor', { 'for': 'php' }

Plug 'preservim/tagbar'
nmap <leader>b :TagbarToggle<cr>

Plug 'vim-airline/vim-airline'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#tagbar#flags = 'f'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
if executable("ag")
	let $FZF_DEFAULT_COMMAND = 'ag -g ""'
endif
nmap <leader>p :GFiles<cr>
nmap <c-p> :Tags<cr>

Plug 'ludovicchabant/vim-gutentags'
let g:gutentags_cache_dir = '~/.vim/gutentags'
let g:gutentags_ctags_exclude = ['*.css', '*.html', '*.js', '*.json', '*.xml', '*.phar', '*.ini', '*.rst', '*.md', '*vendor/*/test*', '*vendor/*/Test*', '*vendor/*/fixture*', '*vendor/*/Fixture*', '*var/cache*', '*var/log*']

Plug 'SirVer/ultisnips'
let g:UltiSnipsExpandTrigger="<c-cr>"
let g:UltiSnipsJumpForwardTrigger="<cr>"
let g:UltiSnipsJumpBackwardTrigger="<c-[>"

Plug 'ncm2/ncm2-ultisnips'
inoremap <silent> <expr> <CR> (pumvisible() ? ncm2_ultisnips#expand_or("\<CR>", 'n') : "\<CR>")

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
Plug 'alvan/vim-php-manual', { 'for': ['php'] }
Plug 'tpope/vim-dadbod', { 'for': ['sql', 'mysql'] }
Plug 'jiangmiao/auto-pairs'
Plug 'romainl/vim-qf'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'

call plug#end()

colorscheme gruvbox
call neomake#configure#automake('nrwi', 500)
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
