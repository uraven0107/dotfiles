filetype off
filetype plugin indent off
" <leader> をスペースキーに割り当てる
let g:mapleader = "\<Space>"

"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
call dein#begin('~/.cache/dein')

" Let dein manage dein
" Required:
call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')

" util
call dein#add('vim-jp/vimdoc-ja')
call dein#add('preservim/nerdtree')
call dein#add('itchyny/lightline.vim')

" 外観
call dein#add('haishanh/night-owl.vim')

" エディタ
call dein#add('cohama/lexima.vim')
call dein#add('andymass/vim-matchup')

" lsp
call dein#add('prabirshrestha/vim-lsp')
call dein#add('mattn/vim-lsp-settings')
call dein#add('prabirshrestha/asyncomplete.vim')
call dein#add('prabirshrestha/asyncomplete-lsp.vim')

" test
call dein#add('vim-test/vim-test')

" go
call dein#add('mattn/vim-goimports')
"call dein#add('fatih/vim-go')

" Required:
call dein#end()

" Required:
" filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------

" カラースキーマの設定
if (has("termguicolors"))
	set termguicolors
endif

colorscheme night-owl

" encoding
set encoding=utf-8

" helpを日本語化
set helplang=ja

" ミュート
set belloff=all

" 改行時自動インデント
set smartindent autoindent

"バックスペースの設定 see ':help i_backspacing' 
set backspace=indent,eol,start

" コマンド履歴保存数
set history=100

" wildmenuを表示する
set wildmenu

" カーソルが何行目の何列目に置かれているかを表示する
set ruler

" コマンド (の一部) を画面の最下行に表示する。
set showcmd

" キーコードのタイムアウト設定
set ttimeout
set ttimeoutlen=100	

" ファイルの最後を切り詰める
set display=truncate

" backupを作成する
set backup
set backupdir=~/.vim/tmp

" undoファイルを作成する
if has('persistent_undo')
  set undofile
  set undodir=~/.vim/tmp
endif

" swpファイルのディレクトリ
set directory=~/.vim/tmp

" 検索ハイライト
set hlsearch
set incsearch

" カーソル表示
set cursorline

" 行番号表示
set number

" ステータスライン表示
set laststatus=2

" タブサイズ
set ts=2

" (自動) インデントで使われるタブのサイズ see :help shiftwidth
" '0'の場合はtabstopの値
set shiftwidth=0

" ターミナル初期サイズ
set termwinsize=10x0

" 保存せずバッファ移動できる
set hidden

" goの設定
augroup go
	autocmd!
	autocmd FileType go set tabstop=4 
augroup END

augroup nerdtree
	autocmd!

	" Start NERDTree when Vim is started without file arguments.
	autocmd StdinReadPre * let s:std_in=1
	autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif

augroup END

" toggle NERDTree
nmap <Leader>nt :NERDTreeToggle<CR> 

" jj入力でESC
inoremap <silent> jj <ESC>

" autocomplete
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"

" NERDTreeで隠しファイルも表示する
let NERDTreeShowHidden=1

" vim-testの結果をterm_start()を使って出力する
let test#strategy = "vimterminal"

filetype plugin indent on
