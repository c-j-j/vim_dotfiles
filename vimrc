" some gems taken from https://bitbucket.org/sjl/dotfiles

set nocompatible
syntax on

filetype off
call pathogen#infect()
filetype plugin indent on

set modelines=0
set encoding=utf-8
set autoindent
set nosmartindent
set history=10000
set number
set background=dark
set hidden
set backspace=indent,eol,start
set textwidth=0

set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

map , \
let mapleader = ","


" search
"nnoremap / /\v
"vnoremap / /\v
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch
noremap <silent> <leader><space> :noh<cr>:call clearmatches()<cr>

"reformats page and go to last edit location
map <Leader>= gg=Gg;

"nnoremap <leader>a :Ack<space>
map <Leader>rt :wa<CR>:call VimuxRunCommand("clear; bundle exec rspec " . bufname("%"))<CR>
map <Leader>ra :wa<CR>:call VimuxRunCommand("clear; bundle exec rspec")<CR>
map <Leader>rs :wa<CR>:call VimuxRunCommand("clear; bundle exec rspec " . bufname("%") . ":" . line("."))<CR>
map <Leader>vl :wa<CR>:VimuxRunLastCommand<CR>

" ctags
nnoremap <silent><Leader>ta :!ctags -R<CR>

" hit ,f to find the definition of the current class
" this uses ctags. the standard way to get this is Ctrl-]
nnoremap <silent> ,f <C-]>

" use ,F to jump to tag in a vertical split
nnoremap <silent> ,F :let word=expand("<cword>")<CR>:vsp<CR>:wincmd w<cr>:exec("tag ". word)<cr>")"

"switch vim windows without using C-W first
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

set cursorline
set wrap
set noswapfile
set bs=2

if &t_Co == 256
  colorscheme Tomorrow-Night
  set t_ut=
endif

" highlight trailing whitespace
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd BufRead,InsertLeave * match ExtraWhitespace /\s\+$/

" set up highlight group & retain through colorscheme changes
highlight ExtraWhitespace ctermbg=red guibg=red
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
map <silent> <LocalLeader>ws :highlight clear ExtraWhitespace<CR>

" highlight too-long lines
autocmd BufRead,InsertEnter,InsertLeave * 2match LineLengthError /\%126v.*/
highlight LineLengthError ctermbg=black guibg=black
autocmd ColorScheme * highlight LineLengthError ctermbg=black guibg=black

" set quickfix window to appear after grep invocation
autocmd QuickFixCmdPost *grep* cwindow

set laststatus=2
set statusline=
set statusline+=%<\                       " cut at start
set statusline+=%2*[%n%H%M%R%W]%*\        " buffer number, and flags
set statusline+=%-40f\                    " relative path
set statusline+=%=                        " seperate between right- and left-aligned
set statusline+=%1*%y%*%*\                " file type
set statusline+=%10(L(%l/%L)%)\           " line
set statusline+=%2(C(%v/125)%)\           " column
set statusline+=%P                        " percentage of file

set undodir=~/.vim/undodir
set undofile
set undolevels=1000 "maximum number of changes that can be undone
set undoreload=10000 "maximum number lines to save for undo on a buffer reload

map <silent> <LocalLeader>nt :NERDTreeToggle<CR>
let g:NERDTreeWinSize = 30
map <silent> <LocalLeader>nr :NERDTree<CR>
map <silent> <LocalLeader>nf :NERDTreeFind<CR>
let NERDTreeShowHidden=1

" not using command t any more
"map <silent> <LocalLeader>t :CommandT<CR>
"map <silent> <LocalLeader>cf :CommandTFlush<CR>
"map <silent> <LocalLeader>cb :CommandTBuffer<CR>
"map <silent> <LocalLeader>cj :CommandTJump<CR>
"map <silent> <LocalLeader>ct :CommandTTag<CR>
"let g:CommandTAcceptSelectionSplitMap=['<C-s>']
"let g:CommandTAcceptSelectionVSplitMap=['<C-v>']
"let g:CommandTCancelMap=['<Esc>', '<C-c>']
"let g:CommandTMaxHeight=10


" If the current buffer has never been saved, it will have no name,
" call the file browser to save it, otherwise just save it.
command! -nargs=0 -bar SaveFile if &modified
      \|    if empty(bufname('%'))
        \|        browse confirm write
        \|    else
          \|        confirm write
          \|    endif
          \|endif

nnoremap <silent> <C-S> :<C-u>SaveFile<CR>
inoremap <c-s> <Esc>:SaveFile<CR>
inoremap <c-s> <c-o>:SaveFile<CR>
vmap <C-s> <esc>:w<CR>gv


imap <C-L> <SPACE>=><SPACE>

"git shortcuts
map <silent> <LocalLeader>gg :Ggrep <C-R><C-W><CR>

" copy and paste to Mac OS X clipboard
noremap <leader>p :set paste<CR>"*p<CR>:set nopaste<CR>
noremap <leader>P :set paste<CR>"*p<CR>:set nopaste<CR>
vnoremap <leader>y "*ygv
noremap <leader>y "*y

" capital Y acts like C, D
noremap Y y$

" move to beginning/end of line
nnoremap B ^
nnoremap E $

" window width
set winwidth=90
set winminwidth=15

" no arrow keys in normal and insert modes
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
vnoremap <up> <nop>
vnoremap <down> <nop>
vnoremap <left> <nop>
vnoremap <right> <nop>
noremap j gj
noremap k gk
noremap gj j
noremap gk k

nnoremap <Leader>r <nop>

" clean trailing whitespace
nnoremap <leader>w mz:%s/\s\+$//<cr>:let @/=''<cr>`z

" Emacs bindings in command line mode
"cnoremap <c-a> <home>
"cnoremap <c-e> <end>

" keep the cursor in place while joining lines
nnoremap J mzJ`z

" split line
" the normal use of S is covered by cc, so don't worry about shadowing it.
nnoremap S i<cr><esc>^mwgk:silent! s/\v +$//<cr>:noh<cr>`w

" disable help
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" convert dos format to unix format
noremap <leader>ff :update<CR>:e ++ff=dos<CR>:setlocal ff=unix<CR>:w<CR>

" HTML tag folding
nnoremap <leader>ft Vatzf

" CSS properties sorting
nnoremap <leader>S ?{<CR>jV/^\s*\}?$<CR>k:sort<CR>:noh<CR>

"set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

Bundle 'christoomey/vim-tmux-navigator'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

