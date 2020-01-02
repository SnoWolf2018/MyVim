set nocompatible " be iMproved, required
filetype off " required
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
"---------------------------
"original repos on github
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'Valloric/YouCompleteMe'
Plugin 'majutsushi/tagbar'
"Plugin 'tmhedberg/SimpylFold'
"------------------------------
"github vim-scripts repos
"Bundle 'SudoEdit.vim'
"Bundle 'ShowPairs'
"Bundle 'Taglist'
"------------------------------
"non github repos
"Bundle 'git://git.wincent.com/command-t.git'

call vundle#end()
filetype plugin indent on

":echo "Hello, world!"    注释:"开头表示注释 
"=========================一般设置======================================= 
set nocompatible          "vim比vi支持更多的功能，如showcmd，避免冲突和副作用，最好关闭兼容 
set encoding=utf-8	  "使用utf-8编码 
set number                "显示行号 
set showcmd               "显示输入命令 
set clipboard=unnamed,unnamedplus    "可以从vim复制到剪贴版中 
set mouse=a               "可以在buffer的任何地方使用鼠标 
set cursorline            "显示当前行 
hi CursorLine   cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
"set cursorcolumn		  "显示当前列 
"hi CursorColumn cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
set hlsearch              "显示高亮搜索 
"set incsearch 
set history=100           "默认指令记录是20 
set ruler                 "显示行号和列号（默认打开) 
set pastetoggle=<F3>      "F3快捷键于paste模式与否之间转化，防止自动缩进 
"set helplang=cn           "设置为中文帮助文档,需下载并配置之后才生效 
set foldmethod=indent
au BufWinLeave * silent mkview "保存文件的折叠状态
au BufRead * silent loadview 	"恢复文件的折叠状态
nnoremap <space> za				
"用空格来切换折叠状态
 
"===========================文本格式排版================================o 
set tabstop=4              "设置tab长度为4 
set shiftwidth=4           "设置自动对齐的缩进级别 
"set cindent                "自动缩进,以c语言风格，例如从if进入下一行，会自动缩进shiftwidth大小 
"set smartindent            "改进版的cindent,自动识别以#开头的注释，不进行换行 
set autoindent              "autoindent配合下面一条命令根据不同语言类型进行不同的缩进操作，更加智能 
filetype plugin indent on 
"set nowrap 
 
"===========================选择solarized的模式========================== 
syntax enable  
syntax on 
"solarzed的深色模式  
"set background=dark 
"solarized的浅色模式 
"set background=light 
"colorscheme solarized        "开启背景颜色模式 
 
"===========================选择molokai的模式============================ 
let g:rehash256 = 1 
let g:molokai_original = 1    "相较于上一个模式，个人比较喜欢此种模式 "highlight NonText guibg=#060606 
"highliGht Folded  guibg=#0A0A0A guifg=#9090D0 
set t_Co=256 
"set background=dark 
set background=light 
colorscheme  molokai   

"===========================选择其他主题的模式============================ 
"colorscheme desert
"colorscheme darkblue
"colorscheme slate

"===========================快捷键设置============================ 
nmap <leader>nt :NERDTree<CR>
noremap <C-N> <Esc>:NERDTree<CR>
nmap <leader>tl :Tlist<CR><c-1>
nmap <leader>tg :TagbarToggle<CR>
"nmap <silent><F4> :TagbarToggle<CR>

"窗口调整快捷键
nmap w= :resize +3<CR>
nmap w- :resize -3<CR>
nmap w, :vertical resize -3<CR>
nmap w. :vertical resize +3<CR>

"标签页跳转快捷键
noremap <C-L> <Esc>:tabnext<CR>
noremap <C-H> <Esc>:tabprevious<CR>

"===========================PluginSettings============================ 

"Taglist Settings
"let Tlist_Show_One_File=1 "只显示当前文件的tags
"let Tlist_WinWidth=20		 "设置taglist宽度
"let Tlist_Exit_OnlyWindow=1 "TagList窗口是最后一个窗口，则退出
"let Tlist_Use_Right_Window=1 "在Vim窗口右侧显示taglist窗口

"YouCompleteMe Settings
"let completeopt=longest,menu
"让vim的补全菜单行为与一般IDE一致（参考VimTip1228）
autocmd InsertLeave * if pumvisible() == 0|pclose|endif "离开插入模式后自动关闭预览窗口
let g:ycm_confirm_extra_conf = 0 "停止提示是否载入本地ycm_extra_conf文件
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm__extra_conf.py' "c family completion path
"let g:ycm_python_binary_path= '/usr/bin/python3' "Python Semantic Completion
let g:ycm_python_binary_path= '/usr/local/bin/python3' "Python Semantic Completion

"tagbar
let g:tagbar_ctags_bin = 'ctags'
let g:tagbar_width = 30

"NERDtree
autocmd StdinReadPre * let s:std_in=1	"当不带参数打开vim时自动加载目录树
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif		"当所有文件关闭时关闭目录树窗格
let g:NERDTreeDirArrowExpandable = '▶'		"修改目录树的显示图标
let g:NERDTreeDirArrowCollapsible = '▼'
let g:NERDTreeWinSize=25		"设置目录树宽度

"===========================一键编译============================ 
func! CompileGcc()
    exec "w"
    let compilecmd="!gcc "
    let compileflag="-o %< "
    if search("mpi\.h") != 0
        let compilecmd = "!mpicc "
    endif
    if search("glut\.h") != 0
        let compileflag .= " -lglut -lGLU -lGL "
    endif
    if search("cv\.h") != 0
        let compileflag .= " -lcv -lhighgui -lcvaux "
    endif
    if search("omp\.h") != 0
        let compileflag .= " -fopenmp "
    endif
    if search("math\.h") != 0
        let compileflag .= " -lm "
    endif
    exec compilecmd." % ".compileflag
endfunc
func! CompileGpp()
    exec "w"
    let compilecmd="!g++ -std=c++11"
    let compileflag="-o %< "
    if search("mpi\.h") != 0
        let compilecmd = "!mpic++ "
    endif
    if search("glut\.h") != 0
        let compileflag .= " -lglut -lGLU -lGL "
    endif
    if search("cv\.h") != 0
        let compileflag .= " -lcv -lhighgui -lcvaux "
    endif
    if search("omp\.h") != 0
        let compileflag .= " -fopenmp "
    endif
    if search("math\.h") != 0
        let compileflag .= " -lm "
    endif
    exec compilecmd." % ".compileflag
endfunc

func! RunPython()
        exec "!python %"
endfunc
func! CompileJava()
    exec "!javac %"
endfunc

func! CompileCode()
        exec "w"
        if &filetype == "cpp"
                exec "call CompileGpp()"
        elseif &filetype == "c"
                exec "call CompileGcc()"
        elseif &filetype == "python"
                exec "call RunPython()"
        elseif &filetype == "java"
                exec "call CompileJava()"
        endif
endfunc

func! RunResult()
        exec "w"
        if search("mpi\.h") != 0
            exec "!mpirun -np 4 ./%<"
        elseif &filetype == "cpp"
            exec "! ./%<"
        elseif &filetype == "c"
            exec "! ./%<"
        elseif &filetype == "python"
            exec "call RunPython"
        elseif &filetype == "java"
            exec "!java %<"
        endif
endfunc

map <F5> :call CompileCode()<CR>
imap <F5> <ESC>:call CompileCode()<CR>
vmap <F5> <ESC>:call CompileCode()<CR>

map <F6> :call RunResult()<CR>

"===========================自动补全括号============================ 
:inoremap ( ()<ESC>i
:inoremap ) <c-r>=ClosePair(')')<CR>
:inoremap { {<CR>}<ESC>O
"by Suzzz:原作者这种设置，输入{会自动补全，并且中间插入一个空行，将光标定位到空行。这对于函数是ok的，但是使用花括号初始化数组、vector时就不方便了。所以改为现在这种：只是补全，然后光标在左右括号中间。
":inoremap { {}<ESC>i
":inoremap } <c-r>=ClosePair('}')<CR>
:inoremap [ []<ESC>i
:inoremap ] <c-r>=ClosePair(']')<CR>
:inoremap " ""<ESC>i
:inoremap ' ''<ESC>i
function! ClosePair(char)
	if getline('.')[col('.')-1] == a:char
		return "\<Right>"
	else
		return a:char
	endif
endfunction
func SkipPair()
	if getline('.')[col('.')-1]==')'||getline('.')[col('.')-1]==']'||getline('.')[col('.')-1]=='}'||getline('.')[col('.')-1]=='''||getline('.')[col('.')-1]=='"'
		return "\<ESC>la"
	else
		return "\t"
	endif
endfunc
"将Control-L键帮定为跳出括号
inoremap <c-l> <c-r>=SkipPair()<CR>
"将TAB键帮定为跳出括号
"inoremap <TAB> <c-r>=SkipPair()<CR>
