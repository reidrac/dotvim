" for long lines
set wrap

" tab business
set tabstop=8
set softtabstop=4
set shiftwidth=4
set expandtab

" ditto
set autoindent

" syntax highlighting
syntax on

" no hl search
set nohlsearch

" try to detect filetypes
filetype on

" enable loading indent file for filetype
filetype plugin indent on

" line numbers
set number

" enable mouse
set mouse=a

" plugin dependent conf starts

call plug#begin('~/.vim/plugged')

" git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" tmux
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'roxma/vim-tmux-clipboard'
Plug 'wincent/terminus'

" life improvements
Plug 'gruvbox-community/gruvbox'
Plug 'scrooloose/nerdtree'
Plug 'qpkorr/vim-bufkill'
Plug 'Chiel92/vim-autoformat'
Plug 'jsfaint/gen_tags.vim'
Plug 'rbong/vim-crystalline'

" language support
Plug 'fatih/vim-go'
Plug 'natebosch/vim-lsc'
Plug 'samsaga2/vim-z80'
Plug 'scrooloose/syntastic'
Plug 'tomtom/tcomment_vim'

call plug#end()

function! StatusLine(current, width)
  let l:s = ''

  if a:current
    let l:s .= crystalline#mode() . crystalline#right_mode_sep('')
  else
    let l:s .= '%#CrystallineInactive#'
  endif
  let l:s .= ' %<%f%h%w%m%r '
  if a:current
    let l:s .= crystalline#right_sep('', 'Fill') . ' %{fugitive#statusline()}'
  else
    let l:s .= ' %{fugitive#statusline()}'
  endif

  let l:s .= '%='
  if a:current
    let l:s .= crystalline#left_sep('', 'Fill') . ' %{&paste ?"PASTE ":""}%{&spell?"SPELL ":""}'
    let l:s .= crystalline#left_mode_sep('')
  endif
  if a:width > 80
    let l:s .= ' %{&ft} [%{&fenc!=#""?&fenc:&enc}][%{&ff}] %3(%c%V%) %l/%L %P '
  else
    let l:s .= ' '
  endif

  return l:s
endfunction

let g:crystalline_enable_sep = 1
let g:crystalline_statusline_fn = 'StatusLine'
let g:crystalline_theme = 'default'

set laststatus=2

" syntastic
let g:syntastic_python_checkers = ['flake8', 'pyflakes']
let g:syntastic_go_checkers = ['go', 'golint', 'govet', 'errcheck']
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_loc_list_height = 5

" default to passive and manual checks
let g:syntastic_mode_map = {
    \ 'mode': 'passive',
    \ 'active_filetypes': [ 'python', 'go' ] }

" make easy to perform a check (C-F6)
noremap <F30> :SyntasticCheck<CR>

"" vim-autoformat (C-F5)
noremap <F29> :Autoformat<CR>

" enable omnicompletion
set omnifunc=syntaxcomplete#Complete

" looks nice
set termguicolors
set background=dark
let g:gruvbox_italic=1
let g:gruvbox_contrast_dark="hard"
let g:gruvbox_guisp_fallback = "fg"
set spell spelllang=en_gb
colorscheme gruvbox

" EOL whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" for tmux, screen, etc
set t_ut=

" default is too slow
set updatetime=500

" re-read the file if changed (if possible)
set autoread
au CursorHold,CursorHoldI * checktime

" make easier to open NERDTree
map <C-n> :NERDTreeToggle<CR>
let NERDTreeQuitOnOpen=1

"" gen_tags.vim (reguires GNU global, aka gtags)
" disable ctags completely, use it through gtags plugin
let g:loaded_gentags#ctags = 1

" LSC conf

" Required for operations modifying multiple buffers like rename.
set hidden

let g:lsc_preview_split_direction = "below"

" dependent on gruvbox theme
highlight link lscDiagnosticError GruvboxRedSign
highlight link lscDiagnosticWarning GruvboxYellowSign

autocmd CompleteDone * silent! pclose

" add you lsc_server_commands and lsc_auto_map locally

