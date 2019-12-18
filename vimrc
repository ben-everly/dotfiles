set nocompatible

" vundle setup
if !empty(glob('~/.vim/autoload/plug.vim'))
	call plug#begin('~/.vim/plug')

	if has ('nvim')
		" autocomplete
		Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
		Plug 'phpactor/phpactor', { 'dir': '~/.vim/plug/phpactor', 'do': 'composer -q -n install' }
		Plug 'kristijanhusak/deoplete-phpactor'
	endif
	" directory tree
	Plug 'scrooloose/nerdtree'
	Plug 'Xuyuanp/nerdtree-git-plugin'

	" syntax errors
	Plug 'neomake/neomake'

	" tags
	Plug 'ludovicchabant/vim-gutentags'
	Plug 'majutsushi/tagbar'

	" search
	Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
	Plug 'junegunn/fzf.vim'

	" xdebug
	Plug 'vim-vdebug/vdebug'

	" git/github integration
	Plug 'tpope/vim-fugitive'
	Plug 'tpope/vim-rhubarb'

	" snippets
	Plug 'SirVer/ultisnips'
	Plug 'honza/vim-snippets'

	Plug 'bling/vim-airline'
	Plug 'morhetz/gruvbox'

	Plug 'git-time-metric/gtm-vim-plugin'

	" language specific
	Plug 'rayburgemeestre/phpfolding.vim', { 'for': 'php' }
	Plug 'tpope/vim-dadbod', { 'for': ['sql', 'mysql'] }
	Plug 'alvan/vim-php-manual', { 'for': ['php'] }

	Plug 'nblock/vim-dokuwiki'
	Plug 'bfredl/nvim-miniyank'
	Plug 'tpope/vim-surround'
	Plug 'tpope/vim-commentary'
	Plug 'kchmck/vim-coffee-script'

	call plug#end()
endif

" formatting and appearance
filetype plugin indent on
syntax enable
augroup filetypes
	autocmd!
	autocmd BufRead,BufNewFile *.ts set ft=javascript
	autocmd BufRead,BufNewFile *.tsx set ft=javascript
augroup END

" other random settings
set number
set foldenable
set wrap
set scrolloff=3 " always show 3 lines above/below cursor
set sidescrolloff=3 " same for left/right
set whichwrap+=hl
set autoread
set noautowrite
set backspace=indent,eol,start
set noerrorbells
set lazyredraw
set hidden " allow switching buffers without saving
set cf " save confirmation when exiting unsaved file
set ffs=unix,dos,mac " use unix line endings
set nosol " dont move the cursor to start of line when using some commands

" display
set cursorline
set list
set listchars=tab:\|\ ,trail:· " show a · for trailing whitespace and a | for tabs
if !empty(glob("~/.vim/plug/gruvbox"))
	colorscheme gruvbox
endif
set background=dark
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set t_Co=256
set termguicolors

" indent
set noexpandtab
set tabstop=4
set shiftwidth=4
set smarttab
set autoindent

" search/command settings
set smartcase
set ignorecase
set incsearch
set hlsearch
set showmatch
set showcmd
set history=1000
set undolevels=1000

" backup directory
let swap = 0
if swap == 1
	if empty(glob('~/.vim/backup'))
		silent !mkdir -p ~/.vim/backup > /dev/null 2>&1
	endif
	set directory=~/.vim/backup " save .swp files in tmp dir
	set backupdir=~/.vim/backup
else
	set noswapfile
endif


" return to last edit position
augroup lastedit
	autocmd!
	autocmd BufReadPost *
		\ if line("'\"") > 0 && line("'\"") <= line("$") |
		\	exe "normal! g`\"" |
		\ endif
augroup END

" statusline
set laststatus=2
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#tagbar#flags = 'f'

" gtm
let g:gtm_plugin_status_enabled = 1

" neomake
call neomake#configure#automake('nrw', 1000)
let g:neomake_open_list = 2

" zfz
function! FindGitRoot()
	return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction
command! ProjectFiles execute 'Files' FindGitRoot()
if executable("ag")
	let $FZF_DEFAULT_COMMAND = 'ag -g ""'
endif

" gutentags
let g:gutentags_cache_dir = '~/.vim/gutentags'
let g:gutentags_ctags_exclude = ['*.css', '*.html', '*.js', '*.json', '*.xml', '*.phar', '*.ini', '*.rst', '*.md', '*vendor/*/test*', '*vendor/*/Test*', '*vendor/*/fixture*', '*vendor/*/Fixture*', '*var/cache*', '*var/log*']

" ultisnips
let g:UltiSnipsExpandTrigger="<c-cr>"
let g:UltiSnipsJumpForwardTrigger="<c-]>"
let g:UltiSnipsJumpBackwardTrigger="<c-[>"
let g:snips_author='ben.everly@oberd.com'

" autocomplete
let g:deoplete#enable_at_startup = 1
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<TAB>"

" vdebug
highlight DbgBreakptLine ctermbg=none ctermfg=none
highlight DbgBreakptSign ctermbg=none ctermfg=10
highlight DbgCurrentLine ctermbg=none ctermfg=none
highlight DbgCurrentSign ctermbg=none ctermfg=red
let g:vdebug_options = {
	\    'port'               : 9000,
	\    'on_close'           : 'detach',
	\    'break_on_open'      : 0,
	\    'path_maps'          : { "/var/www/app": FindGitRoot() },
	\    'watch_window_style' : 'compact',
	\    'continuous_mode'    : 1,
	\    'layout'             : 'vertical',
	\}
let g:vdebug_keymap = {
	\    'run'               : "<leader>d<cr>",
	\    'run_to_cursor'     : "",
	\    "step_over"         : "<leader>dj",
	\    "step_into"         : "<leader>d.",
	\    "step_out"          : "<leader>d,",
	\    "close"             : "<F6>",
	\    "detach"            : "<F7>",
	\    "set_breakpoint"    : "<leader>db",
	\    "get_context"       : "<F11>",
	\    "eval_under_cursor" : "<F12>",
	\    "eval_visual"       : "<Leader>e"
	\}

" nerdtree
augroup nerdtreeinit
	autocmd!
	autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
augroup END
let NERDTreeMinimalUI = 1
let g:NERDTreeIndicatorMapCustom = {
	\     "Modified"  : "-",
	\     "Staged"    : "+",
	\     "Untracked" : "✭",
	\     "Renamed"   : "➜",
	\     "Unmerged"  : "═",
	\     "Deleted"   : "-",
	\     "Dirty"     : "-",
	\     "Clean"     : '+',
	\     'Ignored'   : '',
	\     "Unknown"   : ''
	\ }

" map leader key
let mapleader = " "
nmap <leader>w :w!<cr>
nmap <leader>q :bd<cr>
nmap <leader>l :ls<cr>
nmap <leader><C-t> :enew<cr>
nmap <leader><C-w> :bp\|bd #<cr>
nmap <leader>. :bnext<cr>
nmap <leader>, :bprevious<cr>
nmap <leader>n :NERDTreeToggle<cr>
nmap <leader>N :NERDTreeFind<cr>
nmap <leader>gs :Gstatus<cr>
nmap <leader>gb :Gblame<cr>
nmap <leader>gd :Gdiff<cr>
nmap <leader>gp :Gpull <bar> :Gpush<cr>
nmap <leader>gf :Gfetch<cr>
nmap <leader>gl :Gclog -50<cr>
vmap <leader>gl :'<,'>Gclog -50<cr>
nmap <leader>gh :Gbrowse<cr>
nmap <leader>p :ProjectFiles<cr>
nmap <c-p> :Tags<cr>
nmap <leader>v :call phpactor#GotoDefinition()<cr>
nmap <leader>x :call phpactor#ContextMenu()<cr>
vmap <leader>cf :call phpactor#ExtractMethod()<cr>
nmap <leader>cv :call phpactor#ExtractExpression(v:false)<cr>
vmap <leader>cv :call phpactor#ExtractExpression(v:true)<cr>
nmap <leader>b :TagbarToggle<cr>
nmap <leader>dq :BreakpointRemove *<cr><F7><F6>
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

"miniyank
map p <Plug>(miniyank-startput)
map P <Plug>(miniyank-startPut)
map <leader>] <Plug>(miniyank-cycle)
map <leader>[ <Plug>(miniyank-cycleback)

" custom commands
function! CleanXml()
	%!tidy -q -i --show-errors 0 -xml --hide-comments 1
	%!xmllint --format -
	normal gg=G
endfunction
command! CleanXml exec CleanXml()

" better grep
if executable("ag")
	set grepprg=ag\ --vimgrep\ $*
	set grepformat=%f:%l:%c:%m
endif
function! Grep(args)
	let args = split(a:args, ' ')
	return system(join([&grepprg, shellescape(args[0]), len(args) > 1 ? join(args[1:-1], ' ') : ''], ' '))
endfunction
command! -nargs=+ -complete=file_in_path -bar Grep  cgetexpr Grep(<q-args>)
command! -nargs=+ -complete=file_in_path -bar Lgrep lgetexpr Grep(<q-args>)
augroup quickfix
	autocmd!
	autocmd QuickFixCmdPost cgetexpr cwindow
	autocmd QuickFixCmdPost lgetexpr lwindow
	autocmd FileType qf set nobuflisted
augroup END

nnoremap ; :
cmap w!! w !sudo tee % >/dev/null

function! TabsOrSpaces()
	" Determines whether to use spaces or tabs on the current buffer.
	if getfsize(bufname("%")) > 256000
		" File is very large, just use the default.
		return
	endif

	let numTabs=len(filter(getbufline(bufname("%"), 1, 250), 'v:val =~ "^\\t"'))
	let numSpaces=len(filter(getbufline(bufname("%"), 1, 250), 'v:val =~ "^ "'))

	if numTabs < numSpaces
		setlocal expandtab
	endif
endfunction
augroup indent
	autocmd!
	autocmd BufReadPost * call TabsOrSpaces()
augroup END

function! AirlineInit()
	if exists('*GTMStatusline')
		call airline#parts#define_function('gtmstatus', 'GTMStatusline')
		let g:airline_section_b = airline#section#create([g:airline_section_b, ' ', '[', 'gtmstatus', ']'])
	endif
endfunction
augroup airlineinit
	autocmd!
	autocmd User AirlineAfterInit call AirlineInit()
augroup END

runtime vimrc.local
