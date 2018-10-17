" No reason to limit ourselves to vi compatibility
set nocompatible



"======================"
" vim-plug configuration "
"======================"

call plug#begin('~/.vim/bundle')
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'mileszs/ack.vim'
  Plug 'Valloric/MatchTagAlways'
  Plug 'leafgarland/typescript-vim'
  Plug 'vim-scripts/netrw.vim'
  Plug 'jnurmine/Zenburn'
  Plug 'Valloric/YouCompleteMe'
"  Plug 'tpope/vim-surround'
  Plug 'machakann/vim-sandwich'
  Plug 'altercation/vim-colors-solarized'
  Plug 'chriskempson/base16-vim'
  Plug 'sjl/badwolf'
  Plug 'tpope/vim-sensible'
  Plug 'SirVer/ultisnips'
  Plug 'honza/vim-snippets'
  Plug 'godlygeek/tabular'
  Plug 'junegunn/goyo.vim'
  Plug 'scrooloose/NERDTree'
  Plug 'scrooloose/NERDCommenter'
  Plug 'Lokaltog/powerline'
  Plug 'shime/vim-livedown'
  Plug 'junegunn/vim-easy-align'
  Plug 'xolox/vim-misc'
  Plug 'xolox/vim-session'
  Plug 'sjl/gundo.vim'
  Plug 'lifepillar/vim-cheat40'
  Plug 'mattn/vim-maketable'
  Plug 'https://github.com/Alok/notational-fzf-vim'
  Plug 'fmoralesc/vim-tutor-mode'
  Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
"  Plug 'itchyny/lightline.vim'

  call plug#end()

" Some vim-plug commands:
" :PlugInstall - Install plugins
" :PlugUpdate  - Install or update plugins
" :PlugUpgrade - Upgrade vim-plug itself
" }}}


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable

" Explicitly set the Leader to comma. You you can use '\' (the default),
" or anything else (some people like ';').
let mapleader= "\<Space>"

" Remember command line entries
set history=300

" Reload files when they are changed by another process.
set autoread
augroup checktime
    au!
    if !has("gui_running")
        "silent! necessary otherwise throws errors when using command
        "line window.
        autocmd BufEnter        * silent! checktime
        autocmd CursorHold      * silent! checktime
        autocmd CursorHoldI     * silent! checktime
        "these two _may_ slow things down. Remove if they do.
        autocmd CursorMoved     * silent! checktime
        autocmd CursorMovedI    * silent! checktime
    endif
augroup END

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
" Also don't do it when the mark is in the first line, that is the default
" position when opening a file.
autocmd BufReadPost *
  \ if line("'\"") > 1 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif

" Maintain some setup between sessions
set sessionoptions=blank,buffers,curdir,folds,help,resize,tabpages,winsize

" let g:VCSCommandDisableMappings = 1

" Command to Update plugins and afterwards Upgrade vim-plug
:command! PU PlugUpdate | PlugUpgrade

""""""""""""""""""""""""""""""""""""""""""
""" configuration for notational-fzf-vim
let g:nv_search_paths = ['~/notes']

" String. Set to '' (the empty string) if you don't want an extension appended by default.
" Don't forget the dot, unless you don't want one.
let g:nv_default_extension = '.md'

" String. Default is first directory found in `g:nv_search_paths`. Error thrown
"if no directory found and g:nv_main_directory is not specified
"let g:nv_main_directory = g:nv_main_directory or (first directory in g:nv_search_paths)

" String. Must be in the form 'ctrl-KEY' or 'alt-KEY'
let g:nv_create_note_key = 'ctrl-x'

" String. Controls how new note window is created.
let g:nv_create_note_window = 'vertical split'

" Boolean. Show preview. Set by default. Pressing Alt-p in FZF will toggle this for the current search.
let g:nv_show_preview = 1

" Boolean. Wrap text in preview window.
let g:nv_wrap_preview_text = 1

" Float. Width of preview window as a percentage of screen's width. 50% by default.
let g:nv_preview_width = 72

" String. Determines where the preview window is. Valid options are: 'right', 'left', 'up', 'down'.
let g:nv_preview_direction = 'right'

" Boolean. If set, will truncate each path element to a single character. If
" you have colons in your pathname, this will fail. Not set by default.
let g:nv_use_short_pathnames = 0

"List of Strings. Shell glob patterns. Ignore all filenames that match any of
" the patterns.
let g:nv_ignore_pattern = ['summarize-*', 'misc*']

" List of Strings. Key mappings like above in case you want to define your own
" handler function. Most users won't want to set this to anything.

let g:nv_expect_keys = []

let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Show line numbers
set number
"" Show cursor row and column
set ruler
" Show relative offsets from there. Seriously this is awesome.
set relativenumber

" Make tabs spaces, and all indents 4 spaces
" expandtab adds spaces instead of real tabs
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

" Always yank to the system clipboard
" set clipboard^=unnamed

" Keep undo history, even between vim instances
let s:undoDir = "/home/david/.vim/undodir"
if !isdirectory(s:undoDir) 
    call mkdir(s:undoDir, "", 0700) 
endif 
let &undodir=s:undoDir 
set undofile 

" Hilight the 81st column
set textwidth=80
set colorcolumn=+1

" Shortcut to rapidly toggle `set number` and 'set relativenumber'
nmap <leader>n :set number! relativenumber!<CR>
nmap <leader>s :set relativenumber!<CR>

" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>

" Funtion to Toggle between "no mouse" and "mouse in all modes"
" Can be used via :call ToggleMouse()

function! ToggleMouse()
    " check if mouse is enabled
    if &mouse == 'a'
        " disable mouse
        set mouse=
    else
        " enable mouse everywhere
        set mouse+=a
		set ttymouse=sgr
    endif
endfunc

" Shortcut to rapidly toggle mouse behavior
nmap <leader>c :call ToggleMouse()<CR>

" use » to mark Tabs and ° to mark trailing whitespace. This is a
" non-obtrusive way to mark these special characters.
" set listchars=tab:»\ ,trail:°

" Use the same symbols as TextMate for tabstops and EOLs
" set listchars=tab:▸\ ,eol:¬
"set listchars=tab:▸\ ,eol:¬,trail:·,extends:»,precedes:«,nbsp:‡

" Highlight the search term when you search for it.
set hlsearch

" Show partial commands in the last line of the screen
set showcmd

" Toggle with one key Paste mode, to facilitate copy&paste from clipboard
set pastetoggle=<F2>

" remap ; to do the same as : to avoid one key stroke (Shift)
" nnoremap ; :

" remap jk withing editing mode to exit and go back to normal mode
inoremap jk <ESC>

" Map the process of visualizing buffers and picking one
nnoremap vb :ls<CR>:b<Space>
nnoremap <leader>b :buffer *

" behave like the BASH to complete only the longest possible part and then show
" a list of possible completions with the second <TAB>.
set wildmode=longest:full
set wildmenu

" notational-fzf-vim Mapping
nnoremap <leader>m :NV<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Encoding and locale
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set encoding=utf-8

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files and backups
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set backupcopy=yes

" I don't like Vim to ever write a backup file
set nobackup
set noswapfile


"""""""""""""""""""""""""""""
" => Plugin config
""""""""""""""""""""""""""""""

" => Plugin 'Lokaltog/powerline'
set  rtp+=/usr/local/lib/python2.7/dist-packages/powerline/bindings/vim/
" Always show statusline
set laststatus=2
" Use 256 colours (Use this setting only if your terminal supports 256 colours)
set t_Co=256

" => Plugin 'shime/vim-livedown'
" should markdown preview get shown automatically upon opening markdown buffer
let g:livedown_autorun = 1
" should the browser window pop-up upon previewing
let g:livedown_open = 1
" the port on which Livedown server will run
let g:livedown_port = 1337
" the system command to launch a browser (ex. on linux)
let g:livedown_browser = 'google-chrome-stable %U'

" Livedown shortcut
nmap <leader>gm :LivedownToggle<CR>

" => Plugin 'junegunn/vim-easy-align'
" Align GitHub-flavored Markdown tables
au FileType markdown vmap <Leader><Bslash> :EasyAlign*<Bar><Enter>
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" =>  Plugin 'xolox/vim-session'
let g:session_autoload = "no"
let g:session_autosave = "no"
let g:session_command_aliases = 1

let g:ackprg = 'ag --vimgrep --smart-case'
cnoreabbrev ag Ack
cnoreabbrev aG Ack
cnoreabbrev Ag Ack
cnoreabbrev AG Ack

let $FZF_DEFAULT_COMMAND= 'ag --hidden --ignore .git --ignore-dir googledrive -g ""'

let g:fzf_command_prefix = 'Fzf'

" YouCompleteMe and UliSnips Configuration
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:ycm_key_list_select_completion=['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion=['<C-p>', '<Up>']
" let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_autoclose_preview_window_after_completion = 1

let g:UltiSnipsExpandTrigger="<Tab>"
let g:UltiSnipsJumpForwardTrigger="<Tab>"                                           
let g:UltiSnipsJumpBackwardTrigger="<S-Tab>"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Disable the arrow keys while you’re in normal mode to help you learn to use hjkl

nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>

" It also disables the arrow keys in insert mode to force you to get back into normal mode the instant you’re done inserting text, which is the “right way” to do things.

inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" It also makes j and k work the way you expect instead of working in some archaic “movement by file line instead of screen line” fashion.

nnoremap j gj
nnoremap k gk


" ctrl-jklm  changes to that split
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" set mouse=a
" set mouse+=a
" set ttymouse=sgr


" Visual Mode: Move visual block up or down easily.
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set background=dark
" let g:solarized_termtrans=1
" let g:solarized_termcolors=256
" let g:solarized_contrast="high"
" let g:solarized_visibility="high"
"  colorscheme solarized
" colorscheme badwolf
" call togglebg#map("<F5>")

" base16 colorscheme working.                                                    
" github https://github.com/chriskempson/base16-shell  

if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Saving options
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" vim-session shortcuts
nmap <leader>so :OpenSession
nmap <leader>ss :SaveSession
nmap <leader>sd :DeleteSession<CR>
nmap <leader>sc :CloseSession<CR>

" Automatically change the working path to the path of the current file
augroup reload_vimrc
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-go settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" vim-go configuration
let g:go_version_warning = 0
set autowrite   " Automatically save before :next, :make etc.

" quickfix window commands
map <leader>j :cnext<CR>    " Display the next error in the list
map <leader>k  :cprevious<CR>   " Display the previous error in the list
nnoremap <leader>a :cclose<CR>  " Closes the quickfix window
" Display 'quickfix' and 'locationlist' as quickfix
let g:go_list_type = "quickfix"

" autocmd FileType go nmap <leader>gb  <Plug>(go-build)

" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

" Some mappings for quick access to Go tools (build,run,test,coverage)
autocmd FileType go nmap <leader>gb :<C-u>call <SID>build_go_files()<CR>
autocmd FileType go nmap <leader>gr  <Plug>(go-run)
autocmd FileType go nmap <leader>gt  <Plug>(go-test)
autocmd FileType go nmap <Leader>gc <Plug>(go-coverage-toggle)
autocmd FileType go nmap <Leader>gi :GoImports<CR>

" Automatically imports when formatting go files
let g:go_fmt_command = "gofmt"


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Making Parenthesis And Brackets Handling Easier
" => http://vim.wikia.com/wiki/Making_Parenthesis_And_Brackets_Handling_Easier 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

inoremap ( ()<Esc>:call BC_AddChar(")")<CR>i
inoremap { {<CR>}<Esc>:call BC_AddChar("}")<CR><Esc>kA<CR>
inoremap [ []<Esc>:call BC_AddChar("]")<CR>i
inoremap " ""<Esc>:call BC_AddChar("\"")<CR>i
" jump out of parenthesis
inoremap <C-j> <Esc>:call search(BC_GetChar(), "W")<CR>a

function! BC_AddChar(schar)
 if exists("b:robstack")
 let b:robstack = b:robstack . a:schar
 else
 let b:robstack = a:schar
 endif
endfunction

function! BC_GetChar()
 let l:char = b:robstack[strlen(b:robstack)-1]
 let b:robstack = strpart(b:robstack, 0, strlen(b:robstack)-1)
 return l:char
endfunction

