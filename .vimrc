filetype off
filetype plugin indent off

" <leader> をスペースキーに割り当てる
let g:mapleader = "\<Space>"

"dein Scripts-----------------------------
if &compatible
  set nocompatible
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
call dein#add('alvan/vim-closetag')

" fzf
call dein#add('junegunn/fzf', {'build': './install --all'})
call dein#add('junegunn/fzf.vim')

" lsp
call dein#add('prabirshrestha/vim-lsp')
call dein#add('mattn/vim-lsp-settings')
call dein#add('prabirshrestha/asyncomplete.vim')
call dein#add('prabirshrestha/asyncomplete-lsp.vim')

" debug
call dein#add('puremourning/vimspector')

" test
call dein#add('vim-test/vim-test')

" go
call dein#add('mattn/vim-goimports')
"call dein#add('fatih/vim-go')

" js
call dein#add('prettier/vim-prettier', {'build': 'npm install'})

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
	colorscheme night-owl
endif

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
set ttimeoutlen=200

" ファイルの最後を切り詰める
set display=truncate

" backupを作成する
let s:bk_path = expand('~/.vim/bk')
if !isdirectory(s:bk_path)
	call mkdir(s:bk_path)
endif
execute 'set backupdir=' . s:bk_path
set backup

" undoファイルを作成する
if has('persistent_undo')
	let undo_path = expand('~/.vim/undo')
	if !isdirectory(undo_path)
		call mkdir(undo_path, 'p')
	endif
	execute 'set undodir=' . undo_path
  set undofile
endif

" swpファイルを作成する
let s:swp_path = expand('~/.vim/swp')
if !isdirectory(s:swp_path)
	call mkdir(s:swp_path)
endif
execute 'set directory=' . s:swp_path

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

" 保存せずバッファ移動できる
set hidden

" 新規ウィンドウを下に配置する
set splitbelow

" goの設定
augroup go
	autocmd!
	autocmd FileType go set tabstop=4 
augroup END

" jsの設定
augroup js
	autocmd!
	autocmd FileType javascript set tabstop=4 
augroup END

" toggle NERDTree
nmap <Leader>nt :NERDTreeToggle<CR> 

" jj入力でESC
inoremap <silent> jj <ESC>

" autocomplete
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"

" fzf key-mappings
nnoremap <silent> <leader>f :Files<CR>
nnoremap <silent> <leader>gf :GFiles<CR>
nnoremap <silent> <leader>b :Buffers<CR>

" lsp
nmap <leader>ld <plug>(lsp-definition)
nmap <leader>lr <plug>(lsp-references)

" vim-test
nmap <leader>tf :TestFile<CR>
nmap <leader>tn :TestNearest<CR>
nmap <leader>ts :TestSuite<CR>

" NERDTreeで隠しファイルも表示する
let NERDTreeShowHidden=1

" NERDTreeでファイルを開いたらNERDTreeを閉じる
let g:NERDTreeQuitOnOpen=1

" vim-testの結果をterm_start()を使って出力する
let test#strategy="vimterminal"

" closetag有効ファイル
let g:closetag_filenames='*.html,*.xhtml,*.phtml,*.jsx'
let g:closetag_filetypes='html,xhtml,phtml,javascript'

" 大文字タグでもclosetag有効化
let g:closetag_emptyTags_caseSensitive=1

" prettier自動フォーマット
let g:prettier#autoformat=1

" tagなしでprettierの自動フォーマットが使える
let g:prettier#autoformat_require_pragma=0

" vimspectorのキーマップパターン
" see https://github.com/puremourning/vimspector#human-mode
let g:vimspector_enable_mappings='HUMAN'

filetype plugin indent on
