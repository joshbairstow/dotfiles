call plug#begin('~/.config/nvim/plugged')

" colorschemes
Plug 'morhetz/gruvbox'

" utilities
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'majutsushi/tagbar'

" format
Plug 'nathanaelkane/vim-indent-guides'

" html
Plug 'mattn/emmet-vim', { 'for': 'html' } " emmet support for vim - easily create markdup wth CSS-like syntax

" elm
Plug 'lambdatoast/elm.vim'

" syntax highlighting
Plug 'pangloss/vim-javascript'
Plug 'plasticboy/vim-markdown'

call plug#end()
