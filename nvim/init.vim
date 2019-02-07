" Automate vim-plug install
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

filetype plugin indent on " enable file type detenction and load indent files
set background=dark " Dark, period
set showmatch " show the matching brackets
set showcmd " display incomplete commands
set nonu " turn off numbering
set ruler " show the cursor position all the time
set mouse=a " Mouse events
set clipboard=unnamedplus " yank to clipboard
set formatoptions+=o " Continue comment marker in new lines.
set expandtab " Insert spaces when TAB is pressed.
set backspace=indent,eol,start " make that backspace key work the way it should
set modeline " Enable modeline
set modelines=5
" let c_comment_strings=1 " Highlight strings in C comments
" set laststatus=2 " make status line visible
" set showmode " show the current mode
" let python_highlight_all = 1 " enable all Python syntax highlighting features

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set buftype=nofile | read ++edit # | 0d_ | diffthis
                 \ | wincmd p | diffthis
endif

" Map the leader key to SPACE
let mapleader="\<SPACE>"

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo, so
" that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" Search and Replace
nmap <Leader>s :%s::g<Left><Left>
" toggle line numbering
noremap <Leader>n :set invnumber<CR>

" set/unset indent when moving to the next line while writing code
set autoindent "default = autoindent"
" noremap <C-I> :set invautoindent<CR>
noremap <Leader>i :set invautoindent<CR>

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

" Search with C-P
Plug 'kien/ctrlp.vim'

" Vue syntax
Plug 'posva/vim-vue'

" Jinja syntax
Plug 'lepture/vim-jinja'

" see https://github.com/sbdchd/neoformat

" Initialize plugin system
call plug#end()

" colorscheme configs
" colorscheme Chasing_Logic
" colorscheme space-vim-dark
" colorscheme onedark
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
" Window size
let NERDTreeWinSize=25
" Banner on window (? for commands help)
let NERDTreeMinimalUI=1
let g:nerdtree_tabs_open_on_gui_startup=0

" netrw configuration
" netrw = default fs explorer for vim
" Control 'v' cmd on netrw window open split rigth(if set)/left(default)
" let g:netrw_altv=1
" List as tree
let g:netrw_liststyle=3
" No banner on open (toggle w/ I)
let g:netrw_banner=0
" Open file in (1-sp, 2-vs, 3-new tab, 4-prev window)
let g:netrw_browse_split=5
" Explorer width
let g:netrw_winsize=25
" Open netrw on startup
" augroup ProjectDrawer
"   autocmd!
"   autocmd VimEnter * :Vexplore
" augroup END

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

syntax enable " enable syntax highlighting
syntax on

" Use the below highlight group when displaying bad whitespace is desired.
highlight BadWhitespace ctermbg=red guibg=red

" Display tabs at the beginning of a line in Python mode as bad.
au BufRead,BufNewFile * match BadWhitespace /^\t\+/

" Make trailing whitespace be flagged as bad.
au BufRead,BufNewFile * match BadWhitespace /\s\+$/

" read full
" https://github.com/mhinz/vim-galore
" https://github.com/neovim/neovim/wiki/Development-tips
