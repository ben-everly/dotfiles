set nocompatible

" vundle setup
if !empty(glob('~/.vim/bundle/Vundle.vim'))
	filetype off
	set rtp+=~/.vim/bundle/Vundle.vim
	call vundle#begin()

	Plugin 'VundleVim/Vundle.vim'
	Plugin 'scrooloose/nerdtree'
	Plugin 'tpope/vim-fugitive'
	Plugin 'scrooloose/syntastic'
	Plugin 'kien/ctrlp.vim'
	Plugin 'tpope/vim-surround'
	Plugin 'bling/vim-airline'
	Plugin 'altercation/vim-colors-solarized'
	Plugin 'kchmck/vim-coffee-script'
	Plugin 'SirVer/ultisnips'
	Plugin 'pgilad/vim-skeletons'
	Plugin 'git-time-metric/gtm-vim-plugin'

	call vundle#end()
endif

filetype plugin indent on

" formatting and appearance
syntax on
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

syntax enable
set background=dark
if !empty(glob('~/.vim/bundle/vim-colors-solarized'))
	colorscheme solarized
endif

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

let g:gtm_plugin_status_enabled = 1

" sytastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" ctrlp
let g:ctrlp_custom_ginore = {
	\ 'dir':  '\v[\/](\.(git|hg|svn)|\_site)$',
	\ 'file': '\v\.(exe|so|dll|class|png|jpg|jpeg)$',
\}

" vim-skeletons
let skeletons#autoRegister = 1

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
nmap <leader>gs :Gstatus<cr>
nmap <leader>gb :Gblame<cr>
nmap <leader>gd :Gdiff<cr>
nmap <leader>p :CtrlP<cr>

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
