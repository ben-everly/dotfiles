set nocompatible

" vundle setup
if !empty(glob('~/.vim/autoload/plug.vim'))
	call plug#begin('~/.vim/plug')

	if has ('nvim')
		" autocomplete
		Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
	endif
	" directory tree
	Plug 'scrooloose/nerdtree'
	Plug 'Xuyuanp/nerdtree-git-plugin'

	" syntax errors
	Plug 'scrooloose/syntastic'

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
	Plug 'ruanyl/vim-gh-line'

	Plug 'bling/vim-airline'
	Plug 'morhetz/gruvbox'
	Plug 'SirVer/ultisnips'
	Plug 'pgilad/vim-skeletons'
	Plug 'git-time-metric/gtm-vim-plugin'

	" language specific
	Plug 'rayburgemeestre/phpfolding.vim', { 'for': 'php' }
	Plug 'tpope/vim-dadbod', { 'for': ['sql', 'mysql'] }

	Plug 'nblock/vim-dokuwiki'
	Plug 'tpope/vim-surround'
	Plug 'kchmck/vim-coffee-script'

	call plug#end()
endif

" formatting and appearance
filetype plugin indent on
syntax enable
autocmd BufRead,BufNewFile *.ts set ft=javascript
autocmd BufRead,BufNewFile *.tsx set ft=javascript

set number
set foldenable
set wrap
set noexpandtab
set tabstop=4
set shiftwidth=4
set smarttab
set autoindent
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

" search settings
set smartcase
set ignorecase
set incsearch
set hlsearch
set showmatch
set wildmenu
set history=1000
set undolevels=1000

" backup directory
let swap = 0
if swap == 1
	if empty(glob('~/.vim/backup'))
		silent !mkdir -p ~/.vim/backup > /dev/null 2>&1
	endif
	set directory=~/.vim/backup " save .swp files in tmp dir
else
	set noswapfile
endif
set nobackup
set nowb

" other random settings
set autoread
set noautowrite
set backspace=indent,eol,start
set noerrorbells
set scrolloff=3 " always show 3 lines above/below cursor
set sidescrolloff=3 " same for left/right
set whichwrap+=hl
set showcmd
set ttyfast
set hidden
set lazyredraw
set cf " save confirmation when exiting unsaved file
set ffs=unix,dos,mac " use unix line endings
set nosol " dont move the cursor to start of line when using some commands

" return to last edit position
autocmd BufReadPost *
	\ if line("'\"") > 0 && line("'\"") <= line("$") |
	\	exe "normal! g`\"" |
	\ endif

" statusline
set laststatus=2
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#tagbar#flags = 'f'

let g:gtm_plugin_status_enabled = 1

" sytastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++'

" zfz
function! s:find_git_root()
	return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction
command! ProjectFiles execute 'Files' s:find_git_root()
command! TagUnderCursor execute 'call fzf#vim#tags(expand("<cword>"))'

if executable("ag")
	let $FZF_DEFAULT_COMMAND = 'ag -g ""'
endif

" gutentags
let g:gutentags_cache_dir = '~/.vim/gutentags'
let g:gutentags_ctags_exclude = ['*.css', '*.html', '*.js', '*.json', '*.xml', '*.phar', '*.ini', '*.rst', '*.md', '*vendor/*/test*', '*vendor/*/Test*', '*vendor/*/fixture*', '*vendor/*/Fixture*', '*var/cache*', '*var/log*']

" gh line
let g:gh_line_blame_map_default = 0

" vim-skeletons
let skeletons#autoRegister = 1

" ultisnips
let g:UltiSnipsExpandTrigger="<S-CR>"

" autocomplete
let g:deoplete#enable_at_startup = 1
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<TAB>"

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
nmap <leader>p :ProjectFiles<cr>
nmap <c-p> :Tags<cr>
nmap <leader>v :TagUnderCursor<cr>
nmap <leader>b :TagbarToggle<cr>

" nerdtree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let NERDTreeMinimalUI = 1
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "-",
    \ "Staged"    : "+",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "-",
    \ "Dirty"     : "-",
    \ "Clean"     : '+',
    \ 'Ignored'   : '',
    \ "Unknown"   : ''
    \ }

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
autocmd BufReadPost * call TabsOrSpaces()

function! AirlineInit()
	if exists('*GTMStatusline')
		call airline#parts#define_function('gtmstatus', 'GTMStatusline')
		let g:airline_section_b = airline#section#create([g:airline_section_b, ' ', '[', 'gtmstatus', ']'])
	endif
endfunction
autocmd User AirlineAfterInit call AirlineInit()

runtime vimrc.local
