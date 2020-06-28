" set Vim-specific sequences for RGB colors
" Needed when TERM is st-256color
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

set encoding=UTF-8 " use UTF-8

set exrc " Allows VIM to read .vimrc from working directory, if one exists.
set secure " Stops harmful commands from those dotfiles.

syntax enable " Enables syntax highlighting by default.
set number " Enables line numbering.
set cursorline " Highlights current line.
set wildmenu " Autocompletion menu for vim commands.

set colorcolumn=80 " Highlights 80th column.
highlight ColorColumn ctermbg=black

set cindent " Changes identation rules.
set tabstop=8 " Changes the displayed size of tabs.
set incsearch " Search as characters are entered (incremental search).
set hlsearch  " Highlights matches.
set scrolloff=10 " Stops cursor from reaching bottom (or top) of screen.
set sidescrolloff=10 " Same but horizontally.

autocmd vimenter * NERDTree " Starts NERDTree when VIM starts.

filetype plugin on " Writing of filetype-specific plugins.
autocmd FileType sh setlocal noexpandtab ts=8 sts=8 sw=8
autocmd Filetype c setlocal noexpandtab ts=8 sts=8 sw=8 " rules for C
autocmd Filetype python setlocal expandtab ts=4 sts=4 sw=4 " and Python
" Haskell rules stolen from <http://dmwit.com/tabs/>
autocmd FileType haskell setlocal noet ci pi ts=8 sw=8 sts=0 " and so on
autocmd FileType lilypond setlocal expandtab ts=4 sts=4 sw=4
autocmd FileType sh setlocal noexpandtab ts=8 sts=8 sw=8
autocmd FileType tex setlocal expandtab ts=4 sts=4 sw=4

" Map switching panes to <C-h/j/k/l>
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

"set spell spelllang=en_us " spell checking (only for comments in code)

call plug#begin('~/.vim/plugged')

	" Plugins
	Plug 'itchyny/lightline.vim' " Like Powerline but better
	"Plug 'scrooloose/nerdcommenter' " For commenting multiple lines
	"Plug 'WolfgangMehner/c-support' " C Plugin
	"Plug 'lervag/vimtex' " LaTeX Plugin
	"Plug 'terryma/vim-multiple-cursors' " Multiple cursors
	"Plug 'antoyo/vim-licenses' " For adding license text to buffer
	Plug 'airblade/vim-gitgutter' " Git diff in the gutter
	Plug 'tpope/vim-fugitive' " Git wrapper
	"Plug 'Yggdroot/indentLine' " Show indentation lines
	"Plug 'alx741/vim-stylishask' " Haskell style
	Plug 'neovimhaskell/haskell-vim' " Haskell indent and highlighting

	" Colorschemes
	Plug 'tomasr/molokai' " Colorscheme
	"Plug 'ajmwagar/vim-deus' " Colorscheme
	"Plug 'nanotech/jellybeans.vim' " Colorscheme
	"Plug 'rakr/vim-one' " Colorscheme
	"Plug 'morhetz/gruvbox' " Colorscheme
	Plug 'cocopon/iceberg.vim' " Colorscheme
	"Plug 'kyoz/purify', { 'rtp': 'vim' } " Colorscheme
	"Plug 'HenryNewcomer/vim-theme-papaya' " Colorscheme
	Plug 'fneu/breezy' " Colorscheme
	Plug 'altercation/vim-colors-solarized' " Colorscheme

	Plug 'ryanoasis/vim-devicons' " Icons

call plug#end()

" I dislike how haskell-vim handles indentation, so it's disabled
let g:haskell_indent_disable = 1

let g:lightline = {
      \ 'colorscheme': 'iceberg',
      \ }		" Lightline Colorscheme

set background=dark
set termguicolors " if you want to run vim in a terminal
colorscheme iceberg " Sets the colorscheme
"autocmd FileType mail colorscheme iceberg
"let python_highlight_all=1

let g:NERDTreeWinSize=42 " Changes NERDTree width

"let g:gruvbox_italic = 1
"let g:gruvbox_contrast_dark = 'soft'
"let g:gruvbox_contrast_light = 'hard'

"set background=dark

" Highlighting unwanted whitespaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/

"set listchars=eol:¬,tab:▸\ ,trail:×,extends:>,precedes:<,nbsp:⎵
"set listchars=tab:▸\ ,trail:×,extends:>,precedes:<,nbsp:⎵
set listchars=tab:‣\ ,trail:×,extends:>,precedes:<,nbsp:⎵
set list
