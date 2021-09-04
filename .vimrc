" <leader> をスペースキーに割り当てる
let g:mapleader = "\<Space>"

"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=/home/uraven/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
call dein#begin('/home/uraven/.cache/dein')

" Let dein manage dein
" Required:
call dein#add('/home/uraven/.cache/dein/repos/github.com/Shougo/dein.vim')

" Add or remove your plugins here like this:
"call dein#add('Shougo/neosnippet.vim')
"call dein#add('Shougo/neosnippet-snippets')
call dein#add('vim-jp/vimdoc-ja')
call dein#add('itchyny/lightline.vim')
call dein#add('cohama/lexima.vim')
call dein#add('fatih/vim-go')
call dein#add('preservim/nerdtree')
call dein#add('haishanh/night-owl.vim')
call dein#add('andymass/vim-matchup')

" Required:
call dein#end()

" Required:
filetype plugin indent on
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

" goの設定
augroup go
	autocmd!

	autocmd FileType go set tabstop=4 
	autocmd FileType go let g:go_auto_sameids = 1

	autocmd FileType go imap <C-o> <C-x><C-o>

	autocmd FileType go nmap <Leader>gd <Plug>(go-def-tab)
	autocmd FileType go nmap <Leader>gt :GoTest ./...<CR>
	autocmd FileType go nmap <Leader>gtf <Plug>(go-test-func)
	autocmd FileType go nmap <Leader>gml <Plug>(go-metalinter)
augroup END

" toggle NERDTree
nmap <Leader>nt :NERDTreeToggle<CR> 

" jj入力でESC
inoremap <silent> jj <ESC>

" NERDTreeで隠しファイルも表示する
let NERDTreeShowHidden=1
