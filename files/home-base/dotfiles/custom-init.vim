" _       _ _               _
"(_)_ __ (_) |_      __   _(_)_ __ ___
"| | '_ \| | __|     \ \ / / | '_ ` _ \
"| | | | | | |_   _   \ V /| | | | | | |
"|_|_| |_|_|\__| (_)   \_/ |_|_| |_| |_|

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Make sure vimplug is installed automaticly
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" On normal neovim installed from package manager
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" On Flatpak
" On nornma neovim installed from package manager
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '~/'.var'/app/io.neovim.nvim/data/nvim/site/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Caviats
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Plug 'thaerkh/vim-indentguides' - this Plug in fucked with `` my code quotes




"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => AUTO START SOURCE ORDER
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd VimEnter *
                \   if !argc()
                \ |   Startify
                \ |   NERDTree
                \ |   wincmd w
                \ | endif
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => PLUGINS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin()

" Themes
Plug 'sainnhe/gruvbox-material'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'rebelot/kanagawa.nvim'
Plug 'chriskempson/base16-vim'                                  "This plug adds many very good themes

Plug 'ryanoasis/vim-devicons'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'rebelot/kanagawa.nvim'


"Essentials
Plug 'vimwiki/vimwiki'
Plug 'mhinz/vim-startify'
Plug 'preservim/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'preservim/nerdcommenter'                                  " leader cc to comment selected, Leader cu undo


"Coc
Plug 'neoclide/coc.nvim', {'branch': 'release'}                             " Main Plugin


" fuzzy finders
Plug 'junegunn/fzf'                                             "Need both junegunn/fzf to work on popos?
Plug 'junegunn/fzf.vim'                                         "Need both junegunn/fzf.vim to work on popos?
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}     "Recommended for telescope
Plug 'nvim-lua/plenary.nvim'                                    "Needed for telescope and cheatsheet Plugin
Plug 'sudormrfbin/cheatsheet.nvim'                              "fuzzy cheatsheet
Plug 'nvim-lua/popup.nvim'                                      "needed for cheatsheet


" Emojis
Plug 'nvim-telescope/telescope-symbols.nvim'


"Focus helpers
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'                                   "Recommended to go with goyo

"Visuals/syntax
Plug 'luochen1990/rainbow'                                       " bracket coloring
Plug 'sheerun/vim-polyglot'                                      " Syntax highlighting
Plug 'blueyed/vim-diminactive'                                   " Dim inactive windows
Plug 'stevearc/dressing.nvim'                                    " prettier boxes like on rename

"Quality of Life
Plug 'jiangmiao/auto-pairs'                 " autoclose deimiters
Plug 'tpope/vim-surround'                   " edit tags/delimiters in pairs
Plug 'tpope/vim-repeat'                     " repeat commands with .
Plug 'psliwka/vim-smoothie'                 " Smooth Scrolling
Plug 'antoinemadec/FixCursorHold.nvim'
Plug 'axieax/urlview.nvim'



"Multi Cursor
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'matze/vim-move'                       " move blocks
Plug 'tommcdo/vim-lion'                     " line up text

"snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

"Markdown
Plug 'ellisonleao/glow.nvim', {'branch': 'main'}

"Calendar
Plug 'mattn/calendar-vim'



"Testing again I still have an fyi above for the quote problem
Plug 'thaerkh/vim-indentguides'


call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => PLUGINS SETTINGS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"Vim WIKI

"wiki path and markdown syntax so its not html
    let g:vimwiki_list = [{'path': '$HOME/Documents',
                      \ 'syntax': 'markdown', 'ext': '.md'}]
"wiki regenerate the diary index everytimes its opened automaticly
"the next 2 lines should work but dont so I found a autocmd work around
"let g:vimwiki_list = [{'path': '~/Documents', 'auto_diary_index': 1}]
"let g:vimwiki_list = [{'auto_diary_index': 1}]
"autocmd BufEnter diary.md :VimwikiDiaryGenerateLinks
"THIS IS THE WINNER BELOW FOR AUTO LINKS IN VIM DIARY
let g:vimwiki_list = [{'path': '$HOME/Documents/',
                     \ 'syntax': 'markdown', 'ext': '.md',
                     \ 'auto_diary_index': 1, 'auto_generate_links': 1,
                     \ }]

"NERDTREE
    let NERDTreeShowHidden=1
    let NERDTreeShowLineNumbers=1

"rainbow
    let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle


" Limelight
let g:limelight_conceal_ctermfg = 'gray'      " Color dimming
let g:limelight_conceal_guifg = 'DarkGray'

"Startify


    let g:startify_lists = [
          \ { 'type': 'files',     'header': ['   MRU']            },
          \ { 'type': 'sessions',  'header': ['   Sessions']       },
          \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
          \ { 'type': 'commands',  'header': ['   Commands']       },
          \ ]

    let g:startify_bookmarks = [
          \ { 'z': '$HOME/Dotfiles/Neovim/init.vim' },
          \ { 'v': '$HOME/Dotfiles/zshrc_export_alias'},
          \ ]

"opens new tabs with startify
au! TabNewEntered * Startify                    "starts new tab with startify


"Coc
let g:coc_global_extensions = [ 'coc-python', 'coc-json', 'coc-sh','coc-dictionary','coc-word','coc-syntax','coc-calc','coc-pyright','coc-yank','coc-yaml','coc-marketplace','coc-pyright','coc-lua', 'coc-grammarly', 'coc-godot',   ]
"  TO INSTALL JUST RESTART NEOVIM





""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Language Servers for COC's
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:LanguageClient_serverCommands = {
    \ 'sh': ['bash-language-server', 'start']
    \ }







"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => PLUGINS DEPENDENCIES
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nocompatible                            "vim wiki
filetype plugin on                          "vim wiki
syntax on                                   "vim wiki

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Basic Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set number                                      " Adds line numbers
set relativenumber                              " Highlight the line number i'm on
set cursorline                                 " Where is my cursor
set hidden                                      " hide buffers instead of close
set shell=/usr/bin/zsh                          " set default shell
set ruler                                       " always show cursor
set showcmd                                     " key strokes in command line
set history=1000                                " command history
set timeoutlen=1000 ttimeoutlen=1000            " timeout for keybind presses
set wildmenu wildmode=longest:full,full         " command autocompletion
set autoindent


"wrapping
set wrap                                        " enable text wrapping
set breakindent                                 " smart wrapping indentation
set showbreak=>>                                " shows line break
set linebreak                                   " prevents splitting words to only breakat characters
"set textwidth=79                               " default is 79 don't need this line
set colorcolumn=80


"""""""""basic settings I don't use"""""""""""""""""""""""""""""
"set autowrite                                  " auto save
"set nohlsearch                                 " disable search highlight
":set cursorcolumn                               " Where is my cursor



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => GUI SETTINGS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Neovide only
let g:neovide_transparency=0.95
let g:neovide_cursor_vfx_mode = "railgun"

"adjust font size because it was way to big on laptop
set guifont=Monospace:h12


"Mouse support
set mouse=nicr
set mouse=a

"Clipboard support X11
set clipboard=unnamedplus
"Clipboard support Wayland?
"set clipboard=unnamed

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Theme and Colors
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"colorscheme gruvbox-material               " Default Color scheme
"colorscheme dracula                         " Default Color scheme
colorscheme tokyonight                         " Default Color scheme
set termguicolors                           " Enables Better Colors
set background=dark                         " Dark Backgroud
set t_Co=256                                " Set if term supports 256 colors.



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Directories & Permissions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"set backupdir=$HOME/Documents
"set directory=$HOME/Documents
"set undodir=$HOME/Documents

"These below seem to have fixed my Permissions issues
set nobackup
set noswapfile
set noundofile




"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => REMAPS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"customize vim wiki key bindings"
let g:vimwiki_key_mappings =
\ {
\   'all_maps': 1,
\   'global': 1,
\   'headers': 1,
\   'text_objs': 1,
\   'table_format': 1,
\   'table_mappings': 1,
\   'lists': 1,
\   'links': 1,
\   'html': 1,
\   'mouse': 1,
\ }


"Buffer navigation to HJKL
nnoremap <C-Left> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-Right> <C-w>l

"Vim-smoothie
nnoremap <unique> <C-Down> <cmd>call smoothie#do("\<C-D>") <CR>
vnoremap <unique> <C-Down> <cmd>call smoothie#do("\<C-D>") <CR>
nnoremap <unique> <C-Up> <cmd>call smoothie#do("\<C-U>") <CR>
vnoremap <unique> <C-Up> <cmd>call smoothie#do("\<C-U>") <CR>

"Buffer Cycle with Tab and Shift-Tab
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>

"Set new leader key to space, default is \
let mapleader = " "


"Terminal in vim
map <Leader>tt :vnew term://zsh<CR>

"Select all text
nnoremap <C-A> ggVG

"Toggle Nerd Tree on off
nmap <F6> :NERDTreeToggle<CR>

"Quickly switch buffers with F5
:nnoremap <F5> :buffers<CR>:buffer<Space>

"auto SHBANG in NORMAL mode!!!
noremap bang i#!/usr/bin/env bash<Return><Return># Created By: Rocket<cmd>:pu=strftime('%c')<CR># Created On: <Esc>$ i<Return># Project:


"startify new tab and go back
nnoremap <Leader>t :tabnew<CR>:Startify<CR>
nnoremap <Leader>m :Startify<CR>

"paste last thing yanked, not deleted
nmap ,p "0p
nmap ,P "0P

"write (save) only if something is changed
noremap <Leader>w :up<cr>

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>



"coc-yank list (with space y for yank)
nnoremap <silent> <space>y  :<C-u>CocList -A --normal yank<cr>


" Multiline
  let g:VM_maps = {}
  let g:VM_maps["Add Cursor Down"] = '<Leader>.'
  let g:VM_maps["Add Cursor Up"] = '<Leader>,'
  let g:VM_maps["Undo"] = 'u'
  let g:VM_maps["Redo"] = '<C-r>'


"Save with 'Ctrl+S' in normal,visual,insert modes (must add 'stty -ixon' in zshrc or bash rc)
nnoremap <silent><c-s> :<c-u>update<cr>
vnoremap <silent><c-s> <c-c>:update<cr>gv
inoremap <silent><c-s> <c-o>:update<cr>

"undo + redo to 'ctrl+z and ctrl+shift+z'
nnoremap <c-z> :u<CR>
vnoremap <c-z> :u<CR>
inoremap <c-z> <c-o>:u<CR>
vnoremap <c-z> <c-o>:u<CR>
"redo
inoremap <c-s-z> <c-o><c-r>

" scrolling and selecting text in the auto complete menu
"inoremap <expr> <TAB> pumvisible() ? "\<C-y>" : "\<CR>"
"tab line above didnt work so I disabled it use ctrl+y instead
inoremap <expr> <Esc> pumvisible() ? "\<C-e>" : "\<Esc>"
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<Up>"


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set expandtab                   " Use spaces instead of tabs.
set smarttab                    " Be smart using tabs ;)
set shiftwidth=4                " One tab == four spaces.
set tabstop=4                   " One tab == four spaces.

"Spell check
autocmd BufRead,BufNewFile * setlocal spell spelllang=en_us

" change cursor shape
let &t_SI = "\<Esc>[6 q"                        " insert mode, vertical bar
let &t_SR = "\<Esc>[4 q"                        " replace mode, underscore
let &t_EI = "\<Esc>[2 q"                        " normal mode, block


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Fixes
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" fixes lag of exiting insert/visual mode
if !has('gui_running')
  set ttimeoutlen=10
  augroup FastEscape
    autocmd!
    autocmd InsertEnter * set timeoutlen=0
    autocmd InsertLeave * set timeoutlen=1000
  augroup END
endif


" Override colors
augroup vimrc
  autocmd!
  autocmd ColorScheme * highlight clear Search
        \ | highlight Search ctermbg=None ctermfg=None guibg=Grey42
  autocmd ColorScheme * highlight CocHighlightText ctermbg=None ctermfg=None guibg=Grey35
augroup END


" add cursorline when not in insert mode
augroup cursorLine
  autocmd!
  autocmd VimEnter * set cul
  autocmd InsertLeave * set cul
  autocmd InsertEnter * set nocul
augroup END

" limelight integration
autocmd User GoyoEnter Limelight
autocmd User GoyoLeave Limelight!

" highlight text over 100 chars
if has("nvim")
  augroup highlightText
    autocmd!
    autocmd ColorScheme * highlight OverLength ctermbg=darkgrey guibg=Grey30
    autocmd ColorScheme * match OverLength /\%101v.*/
  augroup END
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Windows
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" WSL yank support
if system('uname -r') =~ "microsoft"
  augroup Yank
    autocmd!
    autocmd TextYankPost * :call system('/mnt/c/windows/system32/clip.exe ',@")
  augroup END
endif



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Work in Progress
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"for flatpak to see node
let g:coc_node_path = '/usr/bin/node'