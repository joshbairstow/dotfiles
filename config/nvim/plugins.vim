call plug#begin('~/.config/nvim/plugged')

" colorschemes
Plug 'morhetz/gruvbox'

" utilities
Plug 'scrooloose/nerdtree'

" html
Plug 'mattn/emmet-vim', { 'for': 'html' } " emmet support for vim - easily create markdup wth CSS-like syntax

" elm
Plug 'lambdatoast/elm.vim'

" syntax highlighting
Plug 'plasticboy/vim-markdown'

call plug#end()
