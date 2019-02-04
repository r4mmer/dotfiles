" enable syntax highlighting
syntax enable
syntax on

" Dark, period
set background=dark

" Map the leader key to SPACE
let mapleader="\<SPACE>"

set showmatch " show the matching brackets
" let python_highlight_all = 1 " enable all Python syntax highlighting features
set nonu " turn off numbering
set ruler " show the cursor position all the time
" set laststatus=2 " make status line visible
set mouse=a " Mouse events
set clipboard=unnamedplus " yank to clipboard
set formatoptions+=o " Continue comment marker in new lines.
set expandtab " Insert spaces when TAB is pressed.
set backspace=indent,eol,start " make that backspace key work the way it should
" set showmode " show the current mode

" Search and Replace
nmap <Leader>s :%s::g<Left><Left>
" toggle line numbering
noremap <Leader>n :set invnumber<CR>

" set/unset indent when moving to the next line while writing code
set autoindent "default = autoindent"
" noremap <C-I> :set invautoindent<CR>

" Show EOL type and last modified timestamp, right after the filename
" set statusline=%<%F%h%m%r\ [%{&ff}]\ (%{strftime(\"%H:%M\ %d/%m/%Y\",getftime(expand(\"%:p\")))})%=%l,%c%V\ %P

" tab navigation
nnoremap <A-q> :tabprevious<CR>
nnoremap <A-e> :tabnext<CR>
inoremap <A-q> <Esc>:tabprevious<CR>
inoremap <A-e>   <Esc>:tabnext<CR>
" open/close tabs
nnoremap <A-p> :tabnew<CR>
nnoremap <A-Delete> :tabclose<CR>
inoremap <A-p> <Esc>:tabnew<CR>
inoremap <A-Delete> <Esc>:tabclose<CR>

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" I don't like folding
"set foldlevelstart=99
"set foldlevel=99

" Begin plugins
call plug#begin('~/.local/share/nvim/plugged')

" Navigation tree
Plug 'scrooloose/nerdtree'

" pretty colors
Plug 'flazz/vim-colorschemes'

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" nvim completion manager (https://github.com/ncm2/ncm2)
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'

" completion sources see https://github.com/ncm2/ncm2/wiki
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'
" python completion
Plug 'ncm2/ncm2-jedi'
" Rust completion see (https://github.com/ncm2/ncm2-racer) and install racer
" Plug 'ncm2/ncm2-racer'
" c/c++ completion see (https://github.com/ncm2/ncm2-pyclang)
Plug 'ncm2/ncm2-pyclang'
" javascript completion
Plug 'ncm2/ncm2-tern',  {'do': 'npm install'}
" vim script completion
Plug 'ncm2/ncm2-vim' | Plug 'Shougo/neco-vim'

" statusline with airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" see https://github.com/sbdchd/neoformat

" Initialize plugin system
call plug#end()

" colorscheme configs
" colorscheme Chasing_Logic
" colorscheme space-vim-dark
colorscheme gruvbox

" Nvim Completion Manager options
" enable ncm2 for all buffers
autocmd BufEnter * call ncm2#enable_for_buffer()

" IMPORTANT: :help Ncm2PopupOpen for more information
set completeopt=noinsert,menuone,noselect
" python interpreter nvim autocomplete manager should use
let g:python3_host_prog = "/usr/local/bin/python3"

" airline configs
" displays all buffers when only one tab is open
let g:airline#extensions#tabline#enabled = 1
" set tabs filename formatter
let g:airline#extensions#tabline#formatter = 'default'
" airline theme, see 'vim-airline/vim-airline-themes' (or :AirlineTheme)
let g:airline_theme='alduin'

" Nerdtree commands
" autocmd VimEnter * NERDTree

" Toggle NERDTree on/off
map <C-x> :NERDTreeToggle<CR>

" Open NERDTree always on the right
let g:NERDTreeWinPos = "right"

" XXX: dunno what this does
" Enable modeline
set modeline
set modelines=5

" testing config tips from https://github.com/ncm2/ncm2
" suppress the annoying messages
set shortmess+=c
" CTRL-C doesn't trigger the InsertLeave autocmd . map to <ESC> instead.
inoremap <c-c> <ESC>
" press <Enter> to close completion popup AND start a new line
" inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")
" Use <TAB> to select the popup menu:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Use the below highlight group when displaying bad whitespace is desired.
highlight BadWhitespace ctermbg=red guibg=red

" Display tabs at the beginning of a line in Python mode as bad.
au BufRead,BufNewFile * match BadWhitespace /^\t\+/

" Make trailing whitespace be flagged as bad.
au BufRead,BufNewFile * match BadWhitespace /\s\+$/

" read full
" https://github.com/mhinz/vim-galore
" https://github.com/neovim/neovim/wiki/Development-tips
