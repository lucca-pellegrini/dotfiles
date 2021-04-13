set encoding=UTF-8 " use UTF-8
scriptencoding utf-8
" set Vim-specific sequences for RGB colors
" Needed when TERM is st-256color
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

set exrc " Allows VIM to read .vimrc from working directory, if one exists.
set secure " Stops harmful commands from those dotfiles.

syntax enable " Enables syntax highlighting by default.
set number " Enables line numbering.
set relativenumber " And makes it relative to cursor
set cursorline " Highlights current line.
set wildmenu " Autocompletion menu for vim commands.
set showcmd " Show partial command list.

set colorcolumn=80 " Highlights 80th column.
highlight ColorColumn ctermbg=black

set cindent " Changes identation rules.
set tabstop=8 " Changes the displayed size of tabs.
set incsearch " Search as characters are entered (incremental search).
set hlsearch  " Highlights matches.
set scrolloff=10 " Stops cursor from reaching bottom (or top) of screen.
set sidescrolloff=10 " Same but horizontally.

"autocmd vimenter * NERDTree " Starts NERDTree when VIM starts.
let g:NERDTreeDirArrowExpandable = ' ' " Changes arrow character
let g:NERDTreeDirArrowCollapsible = ' '
let g:NERDTreeWinSize=25 " Changes NERDTree width

filetype plugin on " Writing of filetype-specific plugins.
augroup indentation
	autocmd FileType sh setlocal noexpandtab ts=8 sts=8 sw=8
	autocmd Filetype c setlocal noexpandtab ts=8 sts=8 sw=8 " rules for C
	autocmd Filetype python setlocal expandtab ts=4 sts=4 sw=4 " and Python
	" Haskell rules stolen from <http://dmwit.com/tabs/>
	autocmd FileType haskell setlocal noet ci pi ts=8 sw=8 sts=0 " so on…
	autocmd FileType lilypond setlocal expandtab ts=4 sts=4 sw=4
	autocmd FileType sh setlocal noexpandtab ts=8 sts=8 sw=8
	autocmd FileType tex setlocal expandtab ts=4 sts=4 sw=4
	autocmd FileType lisp setlocal expandtab ts=2 sts=2 sw=2
augroup END

" Map switching panes to <C-h/j/k/l>
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Use different cursor shapes in different modes *for VTE compatible terminals)
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"

runtime ftplugin/man.vim
call plug#begin('~/.vim/plugged')

	" Plugins
	Plug 'itchyny/lightline.vim'     " Like Powerline but better
	Plug 'neovimhaskell/haskell-vim' " Haskell indent and highlighting
	Plug 'vlime/vlime'               " Lisp plugin
	Plug 'kovisoft/paredit'          " And one of its dependencies
	Plug 'sirtaj/vim-openscad'       " For OpenSCAD files
	Plug 'francoiscabrol/ranger.vim' " For ranger integration
	Plug 'cespare/vim-toml'          " TOML syntax

	" Colorschemes
	Plug 'ajmwagar/vim-deus'
	Plug 'nanotech/jellybeans.vim'
	Plug 'rakr/vim-one'
	Plug 'morhetz/gruvbox'
	Plug 'cocopon/iceberg.vim'
	Plug 'kyoz/purify', { 'rtp': 'vim' }
	Plug 'HenryNewcomer/vim-theme-papaya'
	Plug 'fneu/breezy'
	Plug 'altercation/vim-colors-solarized'
	Plug 'embark-theme/vim', { 'as': 'embark' }
	Plug 'ayu-theme/ayu-vim'
	Plug 'cormacrelf/vim-colors-github'

	Plug 'ryanoasis/vim-devicons' " Icons

call plug#end()

" Set ALE linters and options
let g:ale_linters = #{
	\ c      : ['cc'],
	\ python : ['pylint'],
	\ tex    : ['chktex', 'proselint'],
\}

let g:ale_c_cc_executable = 'cc'
let g:ale_c_cc_options = '-Wall -Wextra -pedantic'

" I dislike how haskell-vim handles indentation, so it's disabled
let g:haskell_indent_disable = 1

set termguicolors " if you want to run vim in a terminal
if $VIM_COLOURS ==? 'light' " A switch/case thing would be useful
	let g:lightline = {'colorscheme': 'iceberg'}
	colorscheme iceberg
	set background=light
elseif $VIM_COLOURS ==? 'github'
	let g:lightline = { 'colorscheme': 'github' }
	colorscheme github
	set background=light
elseif $VIM_COLOURS ==? 'embark'
	let g:embark_terminal_italics = 1
	let g:lightline = {'colorscheme': 'embark'}
	colorscheme embark
	set background=dark
else
	let g:lightline = {'colorscheme': 'iceberg'}
	colorscheme iceberg
	set background=dark
endif

" Highlighting unwanted whitespaces
augroup trailing_space
	highlight ExtraWhitespace ctermbg=red guibg=red
	match ExtraWhitespace /\s\+$/
	autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
	autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
	autocmd InsertLeave * match ExtraWhitespace /\s\+$/
augroup END

" Always display lightline
set laststatus=2

set listchars=eol:\ ,tab:\ \ ,trail:×,extends:▹,precedes:◃,space:\ ,nbsp:%
set list

" Set function to cycle between configured listchars
let s:currentListchars = 0
function! CycleListchars()
	if s:currentListchars
		set listchars=eol:\ ,tab:\ \ ,trail:×,extends:▹,precedes:◃,space:\ ,nbsp:%
	else
		set listchars=eol:¬,tab:┼─,trail:×,extends:▹,precedes:◃,space:·,nbsp:%
	endif

	let s:currentListchars = !s:currentListchars
endfunction

" And another to hide the signcolumn
let s:scl = 1
function! CycleScl()
	if s:scl
		set scl=no
	else
		set scl=auto
	endif

	let s:scl = !s:scl
endfunction

" Map some keys
map <leader>h :nohlsearch<CR>
map <leader>n :set number!<CR>
map <leader>r :set relativenumber!<CR>
map <leader>w :set wrap!<CR>
map <leader>l :call CycleListchars()<CR>
map <leader>s :call CycleScl()<CR>
map <leader>e :Lexplore \| vertical resize 25<CR>

" ft-man-plugin mappings
map <leader>m  :Man<space>
map <leader>mm :Man<space>
map <leader>m1 :Man 1<space>
map <leader>m2 :Man 2<space>
map <leader>m3 :Man 3<space>
map <leader>m4 :Man 4<space>
map <leader>m5 :Man 5<space>
map <leader>m6 :Man 6<space>
map <leader>m7 :Man 7<space>
map <leader>m8 :Man 8<space>
map <leader>m9 :Man 9<space>

" netrw options
let g:netrw_banner = 0
let g:netrw_liststyle = 3 " tree style listing
