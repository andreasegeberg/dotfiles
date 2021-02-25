syntax on
let g:asmsyntax = 'nasm'

" set line numbers
set nu
set ignorecase
set smartcase
set incsearch
set wildmenu
set wildignorecase
" Ignore compiled files
set wildignore=*.o,*~,*.pyc

" Set the + register as the default register.
" After this, every time you simply y or p, Vim will use the system clipboard.
" vim must be compile with +clipboard
" vim --version | grep -e version -e +mouse.* -e +clipboard
set clipboard=unnamedplus

" put swap, backup and undo files in a special location instead of the working directory
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undodir=~/.vim/undo//

" this way I can paste into other apps also but needs vim to be compiled with +Clipboard
" vmap <c-c> "*y     " Yank current selection into system clipboard
" nmap <c-c> "*Y     " Yank current line into system clipboard (if nothing is selected)
" nmap <c-v> "*p     " Paste from system clipboard
" nmap <C-a> ggVG    " Select all

" bookmark directories, write 'space+fp' to output :edit ~/src/weos/**/*
nnoremap <leader>fp  :edit ~/src/weos/
nnoremap <leader>fg  :edit /media/andreas/BACKUP/westermo/guider/

"try
"    colorscheme desert
"    set background=dark
"catch
"endtry
" set color scheme
colorscheme xcodelighthc
" https://i.stack.imgur.com/Cpd5t.png

" Highlight TODO's
hi Comment ctermfg=28 ctermbg=NONE
hi Todo ctermfg=232 ctermbg=226 cterm=bold

" use an orange cursor in insert mode (for tmux!)
"let &t_SI = "\e[6 q"
"let &t_EI = "\e[2 q"
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif
:autocmd InsertEnter * set cul
:autocmd InsertLeave * set nocul


" zoom-in and zoom-out the split windows
noremap zz <c-w>_ \| <c-w>\|
noremap zo <c-w>=

" how I want vim tree view to look
let g:netrw_liststyle = 3
let g:netrw_banner = 0

" Use the Silver Searcher instead of grep
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif
" bind K to grep word under cursor and show in quickfix
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" Always show tabline
"set showtabline = 2

" Install airline (tabline for vim)
" download zip, copy autoload, doc, plugin to .vim folder
" default setting of 'laststatus' is for the statusline to not appear until a split is created, I want it all the time and airline needs it
set laststatus=2
" To add help for vim-airline run the following command in vim
" :helptags $HOME/.vim/doc

" Show filename, line/column in statusline (set laststatus=2)
set statusline=%<\ %f\ %m%r%y%w%=\ L:\ \%l\/\%L\ C:\ \%c\

" Set to auto read when a file is changed from the outside
set autoread
au FocusGained,BufEnter * checktime

" Configure backspace so it acts as it should act (You want this!)
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set matchtime=2

" Add a bit extra margin to the left
set foldcolumn=1

" Enable 256 colors palette in Gnome Terminal
if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Turn trailing spaces bright red
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()
" Also set white space chars
set list
set listchars=tab:›\ ,eol:¬,trail:⋅
