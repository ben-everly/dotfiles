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
Plug 'tpope/vim-sleuth'

call plug#end()

colorscheme gruvbox
set bg=dark

" show a · for trailing whitespace and a | for tabs
set list
set listchars=tab:\|\ ,trail:·
