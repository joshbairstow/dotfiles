call plug#begin('~/.config/nvim/plugged')

" colorschemes
Plug 'morhetz/gruvbox'

" utilities
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" format
Plug 'nathanaelkane/vim-indent-guides'

" html
Plug 'mattn/emmet-vim', { 'for': 'html' }

" elm
Plug 'lambdatoast/elm.vim'

" React snippets
Plug 'SirVer/ultisnips'
Plug 'epilande/vim-es2015-snippets'
Plug 'epilande/vim-react-snippets'

" syntax highlighting
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'plasticboy/vim-markdown'

" syntax formatting
Plug 'prettier/vim-prettier', { 'do': 'npm install', 'for': ['javascript', 'css', 'scss'] }

" fuzzy file find
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

call plug#end()
