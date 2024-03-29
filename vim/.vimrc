" {{{ Set up Vundle, the plugin manager
set nocompatible               " be iMproved
filetype off                   " required!

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/Vundle.vim
" call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
call vundle#begin('~/.vim/bundle')

" plugins of choice
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'tpope/vim-surround'
Plugin 'scrooloose/syntastic'
Plugin 'rodjek/vim-puppet'
Plugin 'rizzatti/dash.vim'
Plugin 'junegunn/fzf'
Bundle 'PProvost/vim-ps1'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" }}} End Vundle config

set t_Co=256

syntax enable
set foldmethod=marker
set ignorecase
set smartcase
set incsearch
set gdefault  " substitutions default to global
set number  " show the line number
set backspace=2  " indent,eol,start
set laststatus=2  " always show status line
set statusline=%<%f\ %h%m%r%=%-20.(line=%l,col=%c%V,totlin=%L%)\%h%m%r%=%-40(,%n%Y%)\%P
set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮,nbsp:␣,trail:•
set list  " render the listchars whitespaces as those characters
let mapleader = ","
nmap ; :

" Whitespace characters {{{
set autoindent
set smartindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
" }}}

" Navigation & UI {{{

map J <PageDown>
map K <PageUp>
map W $
map B ^
map Y y$

" Begining & End of line in Normal mode
noremap H ^
noremap L g_

" more natural movement with wrap on
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" Easy ctrl-based splitted window navigation
noremap <C-h>  <C-w>h
noremap <C-j>  <C-w>j
noremap <C-k>  <C-w>k
noremap <C-l>  <C-w>l

" Easy buffer navigation
noremap <leader>bp :bprevious<cr>
noremap <leader>bn :bnext<cr>

" Splits ,v and ,h to open new splits (vertical and horizontal)
nnoremap <leader>v <C-w>v<C-w>l
nnoremap <leader>s <C-w>s<C-w>j

" Change cursor shape based on mode
" https://www.iterm2.com/documentation-escape-codes.html
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

" Colorscheme
set background=dark

" Airline plugin config
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_tabs = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline_powerline_fonts = 1
let g:airline_theme='angr'
"}}} End Navigation & UI

"{{{ Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_python_python_exec = "python3"
let g:syntastic_python_checkers = ["python"]

let g:syntastic_puppet_puppetlint_args = "--no-80chars-check"
"}}}

"{{{ Dash
nmap <silent> <leader>d <Plug>DashSearch
"}}}

"{{{ Diff highlight color
" From: http://stackoverflow.com/a/13370967/4610994
" Fix the difficult-to-read default setting for diff text highlighting.  The
" " bang (!) is required since we are overwriting the DiffText setting. The
" highlighting for 'Todo' also looks nice (yellow) if you don't like the "MatchParen"
" colors.
highlight! link DiffText Todo
"}}}
