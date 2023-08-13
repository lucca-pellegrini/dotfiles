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
set ignorecase " Ignore case in search
set smartcase " unless search contains uppercase character.
set scrolloff=10 " Stops cursor from reaching bottom (or top) of screen.
set sidescrolloff=10 " Same but horizontally.
set virtualedit=block " Allow virtual editing in block mode.
set display=lastline " Display as much of the last line as possible;.
set nojoinspaces " Do not insert two spaces after ‘.’, ‘?’ or ‘!’ on join.
set formatoptions=croqlj " See ':help fo-table'.
set guioptions=acgfit! " Set options for GVIM
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
	\,a:blinkwait700-blinkoff400-blinkon400-Cursor/lCursor
	\,sm:block-blinkwait175-blinkoff150-blinkon150
set title " Set window title.

" NVim exclusives
if has('nvim')
	set mousescroll=ver:1,hor:1 " Scroll one line at a time with the mouse.
	set pumblend=10 " Make the popup menu semi (pseudo) transparent.
	set winblend=10 " Same, but for floating windows.
endif

" Stop bad editing habits
set backspace=
nnoremap <DEL> <Nop>| " ‘x’ easier to reach.

"autocmd vimenter * NERDTree " Starts NERDTree when VIM starts.
let g:NERDTreeDirArrowExpandable = ' ' " Changes arrow character
let g:NERDTreeDirArrowCollapsible = ' '
let g:NERDTreeWinSize=23 " Changes NERDTree width

filetype plugin on " Writing of filetype-specific plugins.
augroup indentation
	autocmd FileType sh setlocal noexpandtab ts=8 sts=8 sw=8 " Rules for Sh
	autocmd Filetype c setlocal noexpandtab ts=8 sts=8 sw=8 " and for C
	autocmd Filetype python setlocal expandtab ts=4 sts=4 sw=4 " etc.
	" Haskell rules stolen from <http://dmwit.com/tabs/>
	autocmd FileType haskell setlocal noet ci pi ts=8 sw=8 sts=0
	autocmd FileType julia setlocal noet ci pi ts=8 sts=8 sw=8
	autocmd FileType lilypond setlocal expandtab ts=4 sts=4 sw=4
	autocmd FileType sh setlocal noexpandtab ts=8 sts=8 sw=8
	autocmd FileType tex setlocal noexpandtab ts=4 sts=4 sw=4
	autocmd FileType lisp setlocal expandtab ts=2 sts=2 sw=2
augroup END

" Map switching panes to <C-h/j/k/l>
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Use different cursor shapes in different modes (for VTE compatible terminals)
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
	Plug 'tpope/vim-surround'        " For brackets, parentheses et cetera
	Plug 'tpope/vim-commentary'      " Comment stuff out
	Plug 'https://tildegit.org/sloum/gemini-vim-syntax.git' " gmi syntax
	Plug 'vimwiki/vimwiki'           " Personal wiki
	Plug 'https://git.sr.ht/~sircmpwn/hare.vim' " Hare programming
	Plug 'tikhomirov/vim-glsl'       " OpenGL Shading Language runtime
	Plug 'twh2898/vim-scarpet'       " Carpet mod script support
	Plug 'vim-scripts/rcshell.vim'   " Plan 9 rc syntax
	Plug 'PatrBal/vim-textidote'     " LaTeX linter
	Plug 'JuliaEditorSupport/julia-vim' " Julia support
	Plug 'ziglang/zig.vim'           " Zig support
	Plug 'neomutt/neomutt.vim'       " neomuttrc syntax support
	Plug 'mileszs/ack.vim'           " Ack support

	" NVim plugins
	if has('nvim')
		Plug 'akinsho/toggleterm.nvim', {'tag' : '*'}
	endif

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
	Plug 'bluz71/vim-moonfly-colors'
	Plug 'jeffkreeftmeijer/vim-dim'

	Plug 'ryanoasis/vim-devicons' " Icons

call plug#end()

" Set ALE linters and options
let g:ale_linters = {
	\ 'c'      : ['cc', 'ccls'],
	\ 'python' : ['pylint'],
	\ 'tex'    : ['chktex', 'lacheck', 'proselint'],
\}

let g:ale_c_cc_executable = 'cc'
let g:ale_c_cc_options = '-Wall -Wextra -pedantic'
let g:ale_c_ccls_init_options = {
	\ 'cache': {
		\ 'directory': $XDG_DATA_HOME . '/ccls'
	\}
\}
let g:ale_cpp_ccls_init_options = g:ale_c_ccls_init_options

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
elseif $VIM_COLOURS ==? 'moonfly'
	let g:lightline = {'colorscheme': 'moonfly'}
	colorscheme moonfly
	set background=dark
elseif $VIM_COLOURS ==? 'default'
	set background=dark
	colorscheme dim
	set nocursorline nocursorcolumn
	let g:lightline = {'colorscheme': '16color'}
else
	let g:lightline = {'colorscheme': 'iceberg'}
	colorscheme iceberg
	set background=dark
endif

let g:lightline['active'] = {
	\ 'left': [ [ 'mode', 'paste' ],
		\ [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
\ }
let g:lightline['component_function'] = {
	\ 'gitbranch': 'FugitiveHead'
\ }

let g:textidote_jar = '/usr/share/java/textidote.jar'

" Highlighting unwanted whitespaces
augroup trailing_space
	highlight ExtraWhitespace ctermbg=red guibg=red
	match ExtraWhitespace /\s\+$/
	autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
	autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
	autocmd InsertLeave * match ExtraWhitespace /\s\+$/
augroup END

" Highlight selection on yank
au TextYankPost * silent! lua vim.highlight.on_yank
	\ {higroup="IncSearch", timeout=250}

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
nmap <leader>h :nohlsearch<CR>
nmap <leader>n :set number!<CR>
nmap <leader>r :set relativenumber!<CR>
nmap <leader>w :set wrap!<CR>
nmap <leader>l :call CycleListchars()<CR>
nmap <leader>s :call CycleScl()<CR>
nmap <leader>e :NERDTree \| vertical resize 23<CR>
nmap <leader>p :set paste!<CR>

" ft-man-plugin mappings
nmap <leader>m  :Man<space>
nmap <leader>mm :Man<space>
nmap <leader>m1 :Man 1<space>
nmap <leader>m2 :Man 2<space>
nmap <leader>m3 :Man 3<space>
nmap <leader>m4 :Man 4<space>
nmap <leader>m5 :Man 5<space>
nmap <leader>m6 :Man 6<space>
nmap <leader>m7 :Man 7<space>
nmap <leader>m8 :Man 8<space>
nmap <leader>m9 :Man 9<space>

" netrw options
let g:netrw_banner = 0
let g:netrw_liststyle = 3 " tree style listing

if has('nvim') " toggleterm must be manually set up.
	lua require("toggleterm").setup()
endif
