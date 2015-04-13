"---------------------------------------------------------------------------
" vundle
"---------------------------------------------------------------------------
" Note: Skip initialization for vim-tiny or vim-small.
if !1 | finish | endif

if has('vim_starting')
	if &compatible
	set nocompatible
	endif

"	Required:
	set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'violetyk/cake.vim'
"NeoBundle 'rking/ag.vim'
"NeoBundle 'neocomplcache'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'The-NERD-tree'
NeoBundle 'The-NERD-Commenter'
NeoBundle 'unite.vim'
NeoBundle 'unite-locate'
NeoBundle 'TwitVim'
NeoBundle 'thinca/vim-localrc'
NeoBundle 'mattn/gist-vim'
NeoBundle 'motemen/hatena-vim'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'glidenote/memolist.vim'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'h1mesuke/unite-outline'
"NeoBundleLazy 'naberon/vim-cakehtml'
NeoBundle 'rhysd/clever-f.vim'
NeoBundleLazy 'mattn/webapi-vim'
NeoBundleLazy 'violetyk/neco-php'
NeoBundleLazy 'thinca/vim-showtime'
NeoBundleLazy 'glidenote/newdayone.vim'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'violetyk/neocomplete-php.vim'

" color schema {{{
"NeoBundle 'nanotech/jellybeans.vim'
"NeoBundle 'molokai'
"NeoBundle 'rdark'
"NeoBundle 'cschlueter/vim-wombat'
NeoBundle 'altercation/vim-colors-solarized'

" My Bundles here:
" Refer to |:NeoBundle-examples|.
" Note: You don't set neobundle setting in .gvimrc!

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.

NeoBundleCheck

"-------------------------------------------------------------------------------
" 基本設定 Basics
"-------------------------------------------------------------------------------
" ESCの変更
inoremap <C-j> <ESC>
" vimrcを開く
nnoremap <silent> <Space>v  :<C-u>edit $MYVIMRC<CR>
nnoremap <silent> <Space>g  :<C-u>edit $MYGVIMRC<CR>
" 自動的にvimrcを反映
augroup MyAutoCmd
    autocmd!
augroup END

if !has('gui_running') && !(has('win32') || has('win64'))
    " .vimrcの再読込時にも色が変化するようにする
    autocmd MyAutoCmd BufWritePost $MYVIMRC nested source $MYVIMRC
else
    " .vimrcの再読込時にも色が変化するようにする
    autocmd MyAutoCmd BufWritePost $MYVIMRC source $MYVIMRC | 
                \if has('gui_running') | source $MYGVIMRC  
    autocmd MyAutoCmd BufWritePost $MYGVIMRC if has('gui_running') | source $MYGVIMRC
endif

let mapleader = ","              " キーマップリーダー
set scrolloff=5                  " スクロール時の余白確保
"set nobackup                     " バックアップ取らない
set backup
set backupdir=~/backup		     " バックアップファイル格納パス
set autoread                     " 他で書き換えられたら自動で読み直す
"set noswapfile                   " スワップファイル作らない
set noerrorbells

" スワップファイルを作るディレクトリ
if has('win32') || has('win64')
	set directory=$VIM/swap
else
	set directory=$HOME/swap
endif
" スワップファイルの更新間隔文字数
set updatecount=500
set hidden                       " 編集中でも他のファイルを開けるようにする
set backspace=indent,eol,start   " バックスペースでなんでも消せるように
set formatoptions=lmoq           " テキスト整形オプション，マルチバイト系を追加
set vb t_vb=                     " ビープをならさない
set browsedir=buffer             " Exploreの初期ディレクトリ
set whichwrap=b,s,h,l,<,>,[,]    " カーソルを行頭、行末で止まらないようにする
set showcmd                      " コマンドをステータス行に表示
set showmode                     " 現在のモードを表示
set modelines=0                  " モードラインは無効
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8

" OSのクリップボードを使用する
set clipboard+=unnamed

"ヤンクした文字は、システムのクリップボードに入れる"
set clipboard=unnamed

" 行番号非表示
nnoremap <leader>nn :set nonumber<cr> 
" 行番号表示
nnoremap <leader>no :set number<cr> 

" 拡張子でタブ幅変更[tabstop=2]
au BufNewFile,BufRead *.html set wrap tabstop=2 shiftwidth=2
au BufNewFile,BufRead *.ctp set wrap tabstop=2 shiftwidth=2
au BufNewFile,BufRead *.md set wrap tabstop=2 shiftwidth=2
" 拡張子でタブ幅変更[tabstop=2]
au BufNewFile,BufRead *.php    set wrap tabstop=2 shiftwidth=2
au BufNewFile,BufRead *.log    set wrap tabstop=2 shiftwidth=2
au BufNewFile,BufRead *.txt    set wrap tabstop=2 shiftwidth=2

" 改行時に自動でコメントが挿入されるのを防ぐ
autocmd FileType * setlocal formatoptions-=ro

"-------------------------------------------------------------------------------
" カラースキーマ
"-------------------------------------------------------------------------------
set t_Co=256
"colorscheme molokai
"colorscheme jellybeans
"colorscheme wombat256
"colorscheme rdark
let g:solarized_termcolors=256

" I use xterm-256color as my terminfo on tmux 1.7 & Terminal.app on OS X Lion,
" so enable termtrans by manually.
" see https://github.com/altercation/vim-colors-solarized
let g:solarized_termtrans=1

set background=dark
colorscheme solarized

"-------------------------------------------------------------------------------
"" ステータスライン StatusLine
"-------------------------------------------------------------------------------
set laststatus=2 " 常にステータスラインを表示
"カーソルが何行目の何列目に置かれているかを表示する
set ruler
"入力モード時、ステータスラインのカラーを変更
augroup InsertHook
	autocmd!
	autocmd InsertEnter * highlight StatusLine guifg=#ccdc90 guibg=#2E4340
	autocmd InsertLeave * highlight StatusLine guifg=#2E4340 guibg=#ccdc90
augroup END

"-------------------------------------------------------------------------------
" 表示 Apperance
"-------------------------------------------------------------------------------
syntax on
set showmatch         " 括弧の対応をハイライト
set number            " 行番号表示

set list
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%

" 全角スペースの表示
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
match ZenkakuSpace /　/

" カーソル行をハイライト
set cursorline
" カレントウィンドウにのみ罫線を引く
augroup cch
  autocmd! cch
  autocmd WinLeave * set nocursorline
  autocmd WinEnter,BufRead * set cursorline
augroup END

":hi clear CursorLine
":hi CursorLine gui=underline
"highlight CursorLine ctermbg=black guibg=black

" コマンド実行中は再描画しない
set lazyredraw
" 高速ターミナル接続を行う
set ttyfast

set splitbelow
set splitright

"-------------------------------------------------------------------------------
" 移動設定 Move
"-------------------------------------------------------------------------------
" ページ送り
nnoremap <c-d> <c-f>
nnoremap <c-u> <c-b>

" カーソルを表示行で移動する。論理行移動は<C-n>,<C-p>
nnoremap h <Left>
nnoremap j gj
nnoremap k gk
nnoremap l <Right>
nnoremap <Down> gj
nnoremap <Up>   gk

" 0, 9で行頭、行末へ
nnoremap 1 0
nnoremap 0 ^
nnoremap 9 $

" control+bで前のバッファ
map <C-b> <ESC>:bp<CR>
" control+nで次のバッファ
map <C-n> <ESC>:bn<CR>
" control+b+wでバッファを削除する
"map <C-b>w <ESC>:bw<CR>

" 前回終了したカーソル行に移動
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif

" 最後に編集された位置に移動
nnoremap gb '[
nnoremap gp ']

" 対応する括弧に移動
nnoremap [ %
nnoremap ] %

" 最後に変更されたテキストを選択する
nnoremap gc  `[v`]
vnoremap gc <C-u>normal gc<Enter>
onoremap gc <C-u>normal gc<Enter>

" カーソル位置の単語をyankする
nnoremap vy vawy

"ビジュアルモード時vで行末まで選択
vnoremap v g_

" CTRL-hjklでウィンドウ移動
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h

"-------------------------------------------------------------------------------
" インデント Indent
"-------------------------------------------------------------------------------
set autoindent   " 自動でインデント
set smartindent  " 新しい行を開始したときに、新しい行のインデントを現在行と同じ量にする。
set expandtab
"set noexpandtab
set tabstop=2 shiftwidth=2 softtabstop=0

"------------------------------------------------------------------------------------
" PHP関連
"------------------------------------------------------------------------------------
" 文字列中のSQLをハイライトする
let php_sql_query = 1
" 文字列中のHTMLをハイライトする
let php_htmlInStrings = 1


" ヘルプを引きやすくする
"nnoremap <C-h> :<C-u>help<Space>
"nnoremap <C-h><C-h> :<C-u>help<Space><C-r><C-w><CR>

"----------------------------------------------------
" vimrc変更したら自動的に変更が反映されるようにする
" ※もし自動反映でvimの挙動がおかしくなった場合は、ここを参考にする
" http://vim-users.jp/2009/09/hack74/
"----------------------------------------------------
" .vimrcの変更を自動的に反映させるようにする 
augroup MyAutoCmd
	autocmd!
augroup END

if !has('gui_running') && !(has('win32') || has('win64'))
	" .vimrcの再読込時にも色が変化するようにする
	autocmd MyAutoCmd BufWritePost $MYVIMRC nested source $MYVIMRC
else
	" .vimrcの再読込時にも色が変化するようにする
	autocmd MyAutoCmd BufWritePost $MYVIMRC source $MYVIMRC 
endif

nnoremap <leader>rv :source $MYVIMRC<CR>


"----------------------------------------------------
"" 使い捨てのファイルを作成 scratch.vimに代わる方法
"----------------------------------------------------
" Open junk file."{{{
"command! -nargs=0 JunkFile call s:open_junk_file()
"function! s:open_junk_file()
"  let l:junk_dir = $HOME . '/.memo'. strftime('/%Y/%m')
"  if !isdirectory(l:junk_dir)
"	call mkdir(l:junk_dir, 'p')
"  endif
"  
"  let l:filename = input('Junk Code: ', l:junk_dir.strftime('/%Y-%m-%d-%H%M%S.'))
"  if l:filename != ''
"	execute 'edit ' . l:filename
"  endif
"endfunction "}}}
"
"nmap <silent> <F5> :JunkFile<CR>

"------------------------------------------------------------------------------------
" 各プラグインの設定
"------------------------------------------------------------------------------------

"------------------------------------------------------------------------------------
"
" vim戦闘力
"
"------------------------------------------------------------------------------------
function! Scouter(file, ...)
  let pat = '^\s*$\|^\s*"'
  let lines = readfile(a:file)
  if !a:0 || !a:1
    let lines = split(substitute(join(lines, "\n"), '\n\s*\\', '', 'g'), "\n")
  endif
  return len(filter(lines,'v:val !~ pat'))
endfunction
command! -bar -bang -nargs=? -complete=file Scouter
\        echo Scouter(empty(<q-args>) ? $MYVIMRC : expand(<q-args>), <bang>0)
command! -bar -bang -nargs=? -complete=file GScouter
\        echo Scouter(empty(<q-args>) ? $MYGVIMRC : expand(<q-args>), <bang>0)

"----------------------------------------------------
" NERDTree
"----------------------------------------------------
" カラー表示するか
let NERDChristmasTree = 1
" 起動時に隠しファイルを表示するか（あとで切り替えられる）
let NERDTreeShowHidden = 0
" カーソル行を強調するか
let NERDTreeHighlightCursorline = 1
" NERDTreeウィンドウのサイズ
let NERDTreeWinSize = 35
" NERDTreeウィンドウを横に表示するか上に表示するか
let NERDTreeWinPos = "left"
" <F8>で開く/閉じる
"nmap <silent> <F8> :NERDTreeToggle<CR>
nmap <silent> 8 :NERDTreeToggle<CR>

let g:NERDTreeHijackNetrw = 0

"----------------------------------------------------
" neocomplcache.vim
"----------------------------------------------------

"" Disable AutoComplPop.
"let g:acp_enableAtStartup = 0
"" Use neocomplcache.
"let g:neocomplcache_enable_at_startup = 1
"" Use smartcase.
"" Disable AutoComplPop.
"let g:acp_enableAtStartup = 0
"" Use neocomplcache.
"let g:neocomplcache_enable_at_startup = 1
"" Use smartcase.
"let g:neocomplcache_enable_smart_case = 1
"" Use camel case completion.
"let g:neocomplcache_enable_camel_case_completion = 1
"" Use underbar completion.
"let g:neocomplcache_enable_underbar_completion = 1
"" Set minimum syntax keyword length.
"let g:neocomplcache_min_syntax_length = 3
"let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
"" -入力による候補番号の表示
""let g:neocomplcache_enable_quick_match = 1
"
"" Define dictionary.
"if has('win32')
"    let g:neocomplcache_dictionary_filetype_lists = {
"    \ 'default' : '',
"    \ 'vimshell' : $ME.'/.vimshell_hist',
"    \ 'scheme' : $HOME.'/.gosh_completions',
"    \ 'php' : $VIM.'/vimfiles/dict/php.dict',
"    \ }
"else
"    let g:neocomplcache_dictionary_filetype_lists = {
"    \ 'default' : '',
"    \ 'vimshell' : $HOME.'/.vimshell_hist',
"    \ 'scheme' : $HOME.'/.gosh_completions',
"    \ 'php' : $HOME.'/.vim/dict/php.dict',
"    \ } 
"    let g:neocomplcache_snippets_dir = $HOME.'/.vimd/snippets'
"endif
"
"" Define keyword.
"if !exists('g:neocomplcache_keyword_patterns')
"    let g:neocomplcache_keyword_patterns = {}
"endif
"let g:neocomplcache_keyword_patterns['default'] = '\h\w*'
"
"" Plugin key-mappings.
"imap <C-k>     <Plug>(neocomplcache_snippets_expand)
"smap <C-k>     <Plug>(neocomplcache_snippets_expand)
"" undo
"inoremap <expr><C-g>     neocomplcache#undo_completion()
"" 共通の部分まで補完
"inoremap <expr><C-l>     neocomplcache#complete_common_string()
"" 補完候補が出ていたら確定、なければ改行
"inoremap <expr><CR>  pumvisible() ? neocomplcache#close_popup() : "<CR>"
"
"" Recommended key-mappings.
"" <CR>: close popup and save indent.
"inoremap <expr><CR>  neocomplcache#smart_close_popup() ."\<CR>"
"" <TAB>: completion.
"inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
"" <C-h>, <BS>: close popup and delete backword char.
"inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
"inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
"" 補完を選択してポップアップを閉じる。
"inoremap <expr><C-y>  neocomplcache#close_popup()
"" 補完をキャンセルしてポップアップを閉じる
"inoremap <expr><C-c>  neocomplcache#cancel_popup()
"
"" AutoComplPop like behavior.
"" 補完候補の一番先頭を選択しとく
"let g:neocomplcache_enable_auto_select = 1
"
"" Enable omni completion.
"autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
"autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
"autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
"autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
"autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
"
"autocmd FileType php set omnifunc=phpcomplete#CompletePHP

"----------------------------------------------------
" neosnippet
"----------------------------------------------------

" Plugin key-mappings.
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory='~/.vimd/snippets'

"----------------------------------------------------
" neocomplete.vim
"----------------------------------------------------
"Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplete#close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-c>  neocomplete#cancel_popup()
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

" For cursor moving in insert mode(Not recommended)
"inoremap <expr><Left>  neocomplete#close_popup() . "\<Left>"
"inoremap <expr><Right> neocomplete#close_popup() . "\<Right>"
"inoremap <expr><Up>    neocomplete#close_popup() . "\<Up>"
"inoremap <expr><Down>  neocomplete#close_popup() . "\<Down>"
" Or set this.
"let g:neocomplete#enable_cursor_hold_i = 1
" Or set this.
"let g:neocomplete#enable_insert_char_pre = 1

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

"----------------------------------------------------
" unite.vim
"----------------------------------------------------
nnoremap <silent> <Leader>ub :<C-u>Unite buffer<CR>
nnoremap <silent> <Leader>um :<C-u>Unite file_mru<CR>
nnoremap <silent> <Leader>ul :<C-u>Unite locate<CR>
nnoremap <silent> <Leader>ua :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>

" unite.vim上でのキーマッピング
autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()
  " 単語単位からパス単位で削除するように変更
  imap <buffer> <C-w> <Plug>(unite_delete_backward_path)
  " ESCキーを2回押すと終了する
  nmap <silent><buffer> <ESC><ESC> q
  imap <silent><buffer> <ESC><ESC> <ESC>q
endfunction

"----------------------------------------------------
" unite outline
"----------------------------------------------------
nnoremap <silent> <Leader>uo :Unite outline<CR>
"let g:unite_split_rule = "rightbelow"

"---------------------------------------------------------------------------
" zen-coding...
"---------------------------------------------------------------------------
"helptags ~/.vim/ZenCoding.vim/doc/
"let g:user_zen_expandabbr_key = '<C-e>'

"---------------------------------------------------------------------------
" emmet.vim
"---------------------------------------------------------------------------
let g:user_emmet_mode='a'
let g:user_emmet_expandabbr_key = '<C-e>'

"---------------------------------------------------------------------------
" localrc.vim 
"---------------------------------------------------------------------------
call localrc#load('.init.vimrc', $HOME)

"---------------------------------------------------------------------------
" Gist.vim 
"---------------------------------------------------------------------------
let g:gist_curl_options = '-k'
let g:gist_detect_filetype = 1
" ビジュアルモードのgistポストキーマッピング
vnoremap <Leader>gp :Gist<CR><ESC>
" プライベートモードでポスト 
vnoremap <Leader>gpp :Gist -p<CR><ESC>

nnoremap <Leader>gu :Gist -l<Space>
" 自分のgist一覧を開く
nnoremap <Leader>gul :Gist -l tic01<CR>

"---------------------------------------------------------------------------
" TwitVim 
"---------------------------------------------------------------------------
" TwitterPost
nnoremap <Leader>tp :PosttoTwitter<cr>
" TimeLine
nnoremap <Leader>tl :FriendsTwitter<cr>
" @Post
nnoremap <Leader>ta :RepliesTwitter<cr>
" Refresh
"---------------------------------------------------------------------------
" cake.vim
"---------------------------------------------------------------------------
"let g:cakephp_enable_fix_mode = 1
let g:cakephp_enable_auto_mode = 1
nnoremap <Space>cc :Ccontroller
nnoremap <Space>cm :Cmodel
nnoremap <Space>cv :Cview
nnoremap <Space>cvw :Ccontrollerview
nnoremap <Space>cs :Cshell
nnoremap <Space>ct :Ctask
nnoremap <Space>ccf :Cconfig
nnoremap <Space>ccp :Ccomponent
nnoremap <Space>cl :Clog
nnoremap <Space>cb :Cbehavior
nnoremap <Space>ct :Ctest
nnoremap <Space>cf :Cfixture
nnoremap <Space>ch :Chelper
vnoremap <Leader>ce :Celement
vnoremap <Leader>ceo :Celement!

" splitで開くキーバインド設定
nnoremap <Space>ccs :Ccontrollersp
nnoremap <Space>cms :Cmodelsp
nnoremap <Space>cvs :Cviewsp
nnoremap <Space>cvws :Ccontrollerviewsp
nnoremap <Space>ccfs :Cconfigsp
nnoremap <Space>ccps :Ccomponentsp

" vsplitで開くキーバインド設定
nnoremap <Space>ccv :Ccontrollervsp
nnoremap <Space>cmv :Cmodelvsp
nnoremap <Space>cvv :Cviewvsp
nnoremap <Space>cvwv :Ccontrollerviewvsp
nnoremap <Space>ccfv :Cconfigvsp
nnoremap <Space>ccpv :Ccomponentvsp

"---------------------------------------------------------------------------
" memolist.vim
"---------------------------------------------------------------------------
map <Leader>mn :MemoNew<CR>
map <Leader>ml :MemoList<CR>
map <Leader>mg :MemoGrep<CR>

let g:memolist_path = $HOME . "/memo"
let g:memolist_memo_suffix = "txt"
let g:memolist_memo_date = "%Y-%m-%d %H:%M"
let g:memolist_memo_date = "epoch"
let g:memolist_memo_date = "%D %T"
let g:memolist_prompt_tags = "true"
let g:memolist_prompt_categories = "true"
let g:memolist_qfixgrep = "true"

" ctrlp.vimとmemolist.vimの連携
nmap <Leader>mf :exe "CtrlP" g:memolist_path<cr><f5>

"---------------------------------------------------------------------------
" ctrlp.vim
"---------------------------------------------------------------------------
let g:ctrlp_map = '<c-f>'
"nnoremap <Leader>f :CtrlP<CR>
nnoremap <Leader>cc :CtrlPClearAllCaches<CR>
nnoremap <Leader>rl :CtrlPReload<CR>
let g:ctrlp_working_path_mode 	= 0
"let g:ctrlp_by_filename         = 1
"let g:ctrlp_clear_cache_on_exit = 0
"let g:ctrlp_dotfiles 			= 0
"let g:ctrlp_mruf_max            = 500
"
"---------------------------------------------------------------------------
" neocomplete-php.vim
"---------------------------------------------------------------------------
let g:neocomplete_php_locale = 'ja'


if has("gui_running")
	set lines=90 columns=200
endif 
