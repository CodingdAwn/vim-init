" init-plugins.vim -
"
" Created by skywind on 2018/05/31
" Last Modified: 2018/06/10 23:11
"
"======================================================================
" vim: set ts=4 sw=4 tw=78 noet :

"----------------------------------------------------------------------
" 默认情况下的分组，可以再前面覆盖之
"----------------------------------------------------------------------
if !exists('g:bundle_group')
	let g:bundle_group = ['basic', 'tags', 'enhanced', 'filetypes']
	let g:bundle_group += ['tags', 'airline', 'nerdtree', 'ale', 'echodoc']
	let g:bundle_group += ['leaderf', 'python-mode', 'cplusplus', 'neo', 'unity']
	let g:bundle_group += ['markdown', 'cmake', 'coc', 'myself', 'translator']
	let g:bundle_group += ['web', 'go', 'wiki', 'debugger']
endif


"----------------------------------------------------------------------
" 计算当前 vim-init 的子路径
"----------------------------------------------------------------------
let s:home = fnamemodify(resolve(expand('<sfile>:p')), ':h:h')

function! s:path(path)
  let path = expand(s:home . '/' . a:path )
  return substitute(path, '\\', '/', 'g')
endfunc


"----------------------------------------------------------------------
" 在 ~/.vim/bundles 下安装插件
"----------------------------------------------------------------------
call plug#begin(get(g:, 'bundle_home', '~/.vim/bundles'))

"----------------------------------------------------------------------
" 默认插件
"----------------------------------------------------------------------

" 全文快速移动，<leader><leader>f{char} 即可触发
Plug 'easymotion/vim-easymotion'

" Diff 增强，支持 histogram / patience 等更科学的 diff 算法
Plug 'chrisbra/vim-diff-enhanced'

"----------------------------------------------------------------------
" 基础插件
"----------------------------------------------------------------------
if index(g:bundle_group, 'basic') >= 0

  " 展示开始画面，显示最近编辑过的文件
  Plug 'mhinz/vim-startify'

  " 一次性安装一大堆 colorscheme
  Plug 'flazz/vim-colorschemes'

  " 支持库，给其他插件用的函数库
  Plug 'xolox/vim-misc'

  " 用于在侧边符号栏显示 marks （ma-mz 记录的位置）
  Plug 'kshenoy/vim-signature'

  " 用于在侧边符号栏显示 git/svn 的 diff
  Plug 'mhinz/vim-signify'

  " 根据 quickfix 中匹配到的错误信息，高亮对应文件的错误行
  " 使用 :RemoveErrorMarkers 命令或者 <space>ha 清除错误
  "Plug 'mh21/errormarker.vim'

  " 使用 ALT+e 会在不同窗口/标签上显示 A/B/C 等编号，然后字母直接跳转
  Plug 't9md/vim-choosewin'

  " 提供基于 TAGS 的定义预览，函数参数预览，quickfix 预览
  Plug 'skywind3000/vim-preview'
  noremap <F11> :PreviwScroll -10<cr>
  noremap <F12> :PreviwScroll 10<cr>
  noremap <Leader>pe :PreviewGoto edit<cr>
  noremap <Leader>pt :PreviewGoto tabedit<cr>
  autocmd FileType qf nnoremap <silent><buffer> p :PreviewQuickfix<cr>
  autocmd FileType qf nnoremap <silent><buffer> P :PreviewClose<cr>
  noremap <m-]> :PreviewTag <cr>

  " Git 支持
  Plug 'tpope/vim-fugitive'
  " make fugitive async
  command! -bang -nargs=* -complete=file Make AsyncRun -program=make @ <args>

  " 当前单词 下划线
  Plug 'itchyny/vim-cursorword'

  " relative line nunbers
  Plug 'jeffkreeftmeijer/vim-numbertoggle'

  " man in vim 
  Plug 'vim-utils/vim-man'
  " let the neovim's man.vim not to load
  let g:loaded_man = 1

  " 输入快捷键时 提示
  Plug 'liuchengxu/vim-which-key'
  " 这里如果使用延后加载的话 autoload还没有加载 注册命令使用不了
  "Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }

  " surround
  Plug 'tpope/vim-surround'

	" 使用 ALT+E 来选择窗口
	nmap <a-e> <Plug>(choosewin)

	" 默认不显示 startify
	let g:startify_disable_at_vimenter = 0
	let g:startify_session_dir = '~/.vim/session'
 " viminfo在neovim中是不支持的
  if !has('nvim')
		set viminfo='100,n$HOME/.vim/files/info/viminfo'
  endif

  " 使用 <space>ha 清除 errormarker 标注的错误
  noremap <silent><space>ha :RemoveErrorMarkers<cr>

  " signify 调优
  let g:signify_vcs_list = ['git', 'svn']
  let g:signify_sign_add               = '+'
  let g:signify_sign_delete            = '_'
  let g:signify_sign_delete_first_line = '‾'
  let g:signify_sign_change            = '~'
  let g:signify_sign_changedelete      = g:signify_sign_change

  " git 仓库使用 histogram 算法进行 diff
  let g:signify_vcs_cmds = {
        \ 'git': 'git diff --no-color --diff-algorithm=histogram --no-ext-diff -U0 -- %f',
        \}
endif

"----------------------------------------------------------------------
" markdown
"----------------------------------------------------------------------
if index(g:bundle_group, 'markdown') >= 0
  " vim markdown
  "Plug 'godlygeek/tabular'
  "Plug 'plasticboy/vim-markdown'
  
  " markdown预览
  "Plug 'iamcco/mathjax-support-for-mkdp'
  Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

  nmap <leader>mp <Plug>MarkdownPreview
  nmap <leader>ms <Plug>MarkdownPreviewStop
  nmap <leader>mt <Plug>MarkdownPreviewToggle
endif

"----------------------------------------------------------------------
" cmake
"----------------------------------------------------------------------
if index(g:bundle_group, 'cmake') >= 0
  Plug 'vhdirk/vim-cmake'
endif

"----------------------------------------------------------------------
" neovim的一些基础配置
"----------------------------------------------------------------------
if index(g:bundle_group, 'neo') >= 0
  if has('nvim')
    " neovim的终端插件
	  Plug 'kassio/neoterm'
  endif
endif

"----------------------------------------------------------------------
" 增强插件
"----------------------------------------------------------------------
if index(g:bundle_group, 'enhanced') >= 0

  " 用 v 选中一个区域后，ALT_+/- 按分隔符扩大/缩小选区
  "Plug 'terryma/vim-expand-region'

  " 快速文件搜索
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  set rtp+=/usr/local/opt/fzf

  let g:fzf_layout = { 'window': {'width': 0.8, 'height': 0.8} }
  let $FZF_DEFAULT_OPTS='--reverse'
  command! -bang -nargs=* Rg
  \ call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'dir': system('git rev-parse --show-toplevel 2> /dev/null')[:-2]}, <bang>0)

  " 配对括号和引号自动补全
  Plug 'Raimondi/delimitMate'

	" 提供 gist 接口
	"Plug 'lambdalisue/vim-gista', { 'on': 'Gista' }
	
	" ALT_+/- 用于按分隔符扩大缩小 v 选区
	map <m-=> <Plug>(expand_region_expand)
	map <m--> <Plug>(expand_region_shrink)

	" indentLine
	Plug 'Yggdroot/indentLine'
  " 快速grep替换
  Plug 'brooth/far.vim'
  set lazyredraw            " improve scrolling performance when navigating through large results
  set regexpengine=1        " use old regexp engine
  set ignorecase smartcase  " ignore case only when the pattern contains no capital letters

  " shortcut for far.vim find
  nnoremap <silent> <leader>ff  :Farf --source=rg<cr>
  vnoremap <silent> <leader>ff  :Farf --source=rg<cr>

  " shortcut for far.vim replace
  nnoremap <silent> <leader>fr  :Farr --source=rg<cr>
  vnoremap <silent> <leader>fr  :Farr --source=rg<cr>

  " 设置far可以undo
  let g:far#enable_undo=1

  " Track the engine.
  "Plug 'SirVer/ultisnips'
  
  " Snippets are separated from the engine. Add this if you want them:
  "Plug 'honza/vim-snippets'
  "let g:UltiSnipsExpandTrigger="<a-t>"
  "let g:UltiSnipsListSnippets="<a-l>"
  "let g:UltiSnipsJumpForwardTrigger="<c-j>"
  "let g:UltiSnipsJumpBackwardTrigger="<c-k>"
endif

"----------------------------------------------------------------------
" 自动生成 ctags/gtags，并提供自动索引功能
" 不在 git/svn 内的项目，需要在项目根目录 touch 一个空的 .root 文件
" 详细用法见：https://zhuanlan.zhihu.com/p/36279445
"----------------------------------------------------------------------
if index(g:bundle_group, 'tags') >= 0

  " 提供 ctags/gtags 后台数据库自动更新功能
  Plug 'ludovicchabant/vim-gutentags', { 'for':['c', 'cpp'] }

  " 提供 GscopeFind 命令并自动处理好 gtags 数据库切换
  " 支持光标移动到符号名上：<leader>cg 查看定义，<leader>cs 查看引用
  Plug 'skywind3000/gutentags_plus', { 'for':['c', 'cpp'] }

  let g:gutentags_plus_nomap = 1
  " 快捷键remap
  noremap <silent> <leader>gs :GscopeFind s <C-R><C-W><cr>
  noremap <silent> <leader>gg :GscopeFind g <C-R><C-W><cr>
  noremap <silent> <leader>gc :GscopeFind c <C-R><C-W><cr>
  noremap <silent> <leader>gt :GscopeFind t <C-R><C-W><cr>
  noremap <silent> <leader>ge :GscopeFind e <C-R><C-W><cr>
  noremap <silent> <leader>gf :GscopeFind f <C-R>=expand("<cfile>")<cr><cr>
  noremap <silent> <leader>gi :GscopeFind i <C-R>=expand("<cfile>")<cr><cr>
  noremap <silent> <leader>gd :GscopeFind d <C-R><C-W><cr>
  noremap <silent> <leader>ga :GscopeFind a <C-R><C-W><cr>
  noremap <silent> <leader>gz :GscopeFind z <C-R><C-W><cr>

  " 设定项目目录标志：除了 .git/.svn 外，还有 .root 文件
  let g:gutentags_project_root = ['.root']
  let g:gutentags_ctags_tagfile = '.tags'

  " 默认生成的数据文件集中到 ~/.cache/tags 避免污染项目目录，好清理
  let g:gutentags_cache_dir = expand('~/.cache/tags')

  " 默认禁用自动生成
  let g:gutentags_modules = []

  " 如果有 ctags 可执行就允许动态生成 ctags 文件
  if executable('ctags')
    let g:gutentags_modules += ['ctags']
  endif

  " 如果有 gtags 可执行就允许动态生成 gtags 数据库
  if executable('gtags') && executable('gtags-cscope')
    let g:gutentags_modules += ['gtags_cscope']
  endif

  " 设置 ctags 的参数
  let g:gutentags_ctags_extra_args = []
  let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
  let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
  let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

  " 使用 universal-ctags 的话需要下面这行，请反注释
  " let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']

  " 禁止 gutentags 自动链接 gtags 数据库
  let g:gutentags_auto_add_gtags_cscope = 0

  " guntentags_plus 开启
  let g:gutentags_plus_switch = 1

  " debug gutentags
  "let g:gutentags_trace = 1
  let g:gutentags_exclude_filetypes = ['gitcommit', 'gitconfig', 'gitrebase', 'gitsendemail', 'git', 'cmake', 'text', 'yaml']
  let g:gutentags_ctags_exclude = [
  \  '*.git', '*.svn', '*.hg',
  \  'cache', 'build', 'dist', 'bin', 'node_modules', 'bower_components',
  \  '*-lock.json',  '*.lock',
  \  '*.min.*',
  \  '*.bak',
  \  '*.zip',
  \  '*.txt',
  \  '*.pyc',
  \  '*.class',
  \  '*.sln',
  \  '*.csproj', '*.csproj.user',
  \  '*.tmp',
  \  '*.cache',
  \  '*.vscode',
  \  '*.pdb',
  \  '*.exe', '*.dll', '*.bin',
  \  '*.mp3', '*.ogg', '*.flac',
  \  '*.swp', '*.swo',
  \  '.DS_Store', '*.plist',
  \  '*.bmp', '*.gif', '*.ico', '*.jpg', '*.png', '*.svg',
  \  '*.rar', '*.zip', '*.tar', '*.tar.gz', '*.tar.xz', '*.tar.bz2',
  \  '*.pdf', '*.doc', '*.docx', '*.ppt', '*.pptx', '*.xls',
  \]
endif
"----------------------------------------------------------------------
" 文本对象：textobj 全家桶
"----------------------------------------------------------------------
if index(g:bundle_group, 'textobj') >= 0

  " 基础插件：提供让用户方便的自定义文本对象的接口
  Plug 'kana/vim-textobj-user'

  " indent 文本对象：ii/ai 表示当前缩进，vii 选中当缩进，cii 改写缩进
  Plug 'kana/vim-textobj-indent'

  " 语法文本对象：iy/ay 基于语法的文本对象
  Plug 'kana/vim-textobj-syntax'

  " 函数文本对象：if/af 支持 c/c++/vim/java
  Plug 'kana/vim-textobj-function', { 'for':['c', 'cpp', 'vim', 'java'] }

  " 参数文本对象：i,/a, 包括参数或者列表元素
  Plug 'sgur/vim-textobj-parameter'

  " 提供 python 相关文本对象，if/af 表示函数，ic/ac 表示类
  Plug 'bps/vim-textobj-python', {'for': 'python'}

  " 提供 uri/url 的文本对象，iu/au 表示
  Plug 'jceb/vim-textobj-uri'
endif


"----------------------------------------------------------------------
" 文件类型扩展
"----------------------------------------------------------------------
if index(g:bundle_group, 'filetypes') >= 0

  " powershell 脚本文件的语法高亮
  "Plug 'pprovost/vim-ps1', { 'for': 'ps1' }

  " lua 语法高亮增强
  Plug 'tbastos/vim-lua', { 'for': 'lua' }

  " C++ 语法高亮增强，支持 11/14/17 标准
  Plug 'octol/vim-cpp-enhanced-highlight', { 'for': ['c', 'cpp'] }

  " 额外语法文件
  Plug 'justinmk/vim-syntax-extra', { 'for': ['c', 'bison', 'flex', 'cpp'] }

  " python 语法文件增强
  Plug 'vim-python/python-syntax', { 'for': ['python'] }

  " rust 语法增强
  Plug 'rust-lang/rust.vim', { 'for': 'rust' }

  " vim-cpp-enhanced-highlight c++语法高亮
  let g:cpp_class_scope_highlight = 1
  let g:cpp_member_variable_highlight = 1
  let g:cpp_class_decl_highlight = 1
  let g:cpp_experimental_template_highlight = 1
  let g:cpp_concepts_highlight = 1
  let g:cpp_no_function_highlight = 1
endif

" airline
"----------------------------------------------------------------------
if index(g:bundle_group, 'airline') >= 0
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
	let g:airline_left_sep = ''
	let g:airline_left_alt_sep = ''
	let g:airline_right_sep = ''
	let g:airline_right_alt_sep = ''
	let g:airline_powerline_fonts = 0
	let g:airline_exclude_preview = 1
	let g:airline_section_b = '%n'
	let g:airline_theme='deus'
	let g:airline#extensions#branch#enabled = 0
	let g:airline#extensions#syntastic#enabled = 0
	let g:airline#extensions#fugitiveline#enabled = 0
	let g:airline#extensions#csv#enabled = 0
	let g:airline#extensions#vimagit#enabled = 0

	" 显示搜索的索引 以及搜索到的总个数
	Plug 'google/vim-searchindex'
endif


"----------------------------------------------------------------------
" NERDTree
"----------------------------------------------------------------------
if index(g:bundle_group, 'nerdtree') >= 0
  "Plug 'scrooloose/nerdtree', {'on': ['NERDTree', 'NERDTreeFocus', 'NERDTreeToggle', 'NERDTreeCWD', 'NERDTreeFind'] }
  Plug 'scrooloose/nerdtree'
  "Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
  let g:NERDTreeMinimalUI = 1
  let g:NERDTreeDirArrows = 1
  let g:NERDTreeHijackNetrw = 0
  noremap <space>nn :NERDTree<cr>
  noremap <space>no :NERDTreeFocus<cr>
  noremap <space>nm :NERDTreeMirror<cr>
  noremap <space>nt :NERDTreeToggle<cr>
  noremap <space>nc :NERDTree %<cr>
  let NERDTreeWinPos = 'right'
endif

"----------------------------------------------------------------------
" ale：动态语法检查
"----------------------------------------------------------------------
if index(g:bundle_group, 'ale') >= 0
  "Plug 'w0rp/ale'

  " 设定延迟和提示信息
  let g:ale_completion_delay = 500
  let g:ale_echo_delay = 20
  let g:ale_lint_delay = 500
  let g:ale_echo_msg_format = '[%linter%] %code: %%s'

  " 设定检测的时机：normal 模式文字改变，或者离开 insert模式
  " 禁用默认 INSERT 模式下改变文字也触发的设置，太频繁外，还会让补全窗闪烁
  let g:ale_lint_on_text_changed = 'normal'
  let g:ale_lint_on_insert_leave = 1

  " 在 linux/mac 下降低语法检查程序的进程优先级（不要卡到前台进程）
  if has('win32') == 0 && has('win64') == 0 && has('win32unix') == 0
    let g:ale_command_wrapper = 'nice -n5'
  endif

  " 允许 airline 集成
  let g:airline#extensions#ale#enabled = 1

  " 编辑不同文件类型需要的语法检查器
  let g:ale_linters = {
        \ 'python': ['pylint'],
        \ 'lua': ['luac'],
        \ 'go': ['gofmt'],
        \ 'java': ['javac'],
        \ 'cs': ['OmniSharp'],
        \ 'javascript': ['eslint'],
        \ }

  " fixers
  let b:ale_fixers = {'go': ['gofmt', 'goimports']}
  " compile commands json
  let g:ale_c_parse_compile_commands = 1

  " 获取 pylint, flake8 的配置文件，在 vim-init/tools/conf 下面
  function s:lintcfg(name)
    let conf = s:path('tools/conf/')
    let path1 = conf . a:name
    let path2 = expand('~/.vim/linter/'. a:name)
    if filereadable(path2)
      return path2
    endif
    return shellescape(filereadable(path2)? path2 : path1)
  endfunc

  " 设置 flake8/pylint 的参数
  let g:ale_python_flake8_options = '--conf='.s:lintcfg('flake8.conf')
  let g:ale_python_pylint_options = '--rcfile='.s:lintcfg('pylint.conf')
  let g:ale_python_pylint_options .= ' --disable=W'
  let g:ale_c_gcc_options = '-Wall -O2 -std=c99'
  let g:ale_cpp_gcc_options = '-Wall -O2 -std=c++14'
  let g:ale_c_cppcheck_options = '-f'
  let g:ale_cpp_cppcheck_options = '-f'
  let g:ale_c_clangcheck_options = '--extra-arg="-w"'
  let g:ale_cpp_clangcheck_options = '--extra-arg="-w"'

  "let g:ale_linters.text = ['textlint', 'write-good', 'languagetool']

  " 如果没有 gcc 只有 clang 时（FreeBSD）
  if executable('gcc') == 0 && executable('clang')
    let g:ale_linters.c += ['clang']
    let g:ale_linters.cpp += ['clang']
  endif
endif

"----------------------------------------------------------------------
" echodoc：搭配 YCM/deoplete 在底部显示函数参数
"----------------------------------------------------------------------
if index(g:bundle_group, 'echodoc') >= 0
  "Plug 'Shougo/echodoc.vim'
  "set noshowmode
  "let g:echodoc#enable_at_startup = 1
endif

"----------------------------------------------------------------------
" LeaderF：CtrlP / FZF 的超级代替者，文件模糊匹配，tags/函数名 选择
"----------------------------------------------------------------------
if index(g:bundle_group, 'leaderf') >= 0
  " 如果 vim 支持 python 则启用  Leaderf
  if has('python') || has('python3')
    Plug 'Yggdroot/LeaderF', {'do': '.\install.bat'}

    " CTRL+p 打开文件模糊匹配
    let g:Lf_ShortcutF = '<c-p>'

    " ALT+n 打开 buffer 模糊匹配
    let g:Lf_ShortcutB = '<m-n>'

    " CTRL+n 打开最近使用的文件 MRU，进行模糊匹配
    noremap <c-n> :LeaderfMru<cr>

    " ALT+p 打开函数列表，按 i 进入模糊匹配，ESC 退出
    noremap <m-p> :LeaderfFunction!<cr>

    " ALT+SHIFT+p 打开 tag 列表，i 进入模糊匹配，ESC退出
    noremap <m-P> :LeaderfBufTag!<cr>

    " ALT+n 打开 buffer 列表进行模糊匹配
    noremap <m-n> :LeaderfBuffer<cr>

    " 全局 tags 模糊匹配
    noremap <m-m> :LeaderfTag<cr>

    " 最大历史文件保存 2048 个
    let g:Lf_MruMaxFiles = 2048

    " ui 定制
    let g:Lf_StlSeparator = { 'left': '', 'right': '', 'font': '' }

    " 如何识别项目目录，从当前文件目录向父目录递归知道碰到下面的文件/目录
    let g:Lf_RootMarkers = ['.project', '.root', '.svn', '.git']
    let g:Lf_WorkingDirectoryMode = 'Ac'
    let g:Lf_WindowHeight = 0.30
    let g:Lf_CacheDirectory = expand('~/.vim/cache')

    " 每次启动leaderf时刷新缓存
    let g:Lf_UseCache = 0
    let g:Lf_UseMemoryCache = 0

    " 显示绝对路径
    let g:Lf_ShowRelativePath = 0

    " 隐藏帮助
    let g:Lf_HideHelp = 1

    " 模糊匹配忽略扩展名
    let g:Lf_WildIgnore = {
          \ 'dir': ['.svn','.git','.hg'],
          \ 'file': ['*.sw?','~$*','*.bak','*.exe','*.o','*.so','*.py[co]']
          \ }

    " MRU 文件忽略扩展名
    let g:Lf_MruFileExclude = ['*.so', '*.exe', '*.py[co]', '*.sw?', '~$*', '*.bak', '*.tmp', '*.dll']
    let g:Lf_StlColorscheme = 'powerline'

    " 禁用 function/buftag 的预览功能，可以手动用 p 预览
    let g:Lf_PreviewResult = {'Function':0, 'BufTag':0}

    " 使用 ESC 键可以直接退出 leaderf 的 normal 模式
    let g:Lf_NormalMap = {
          \ "File":   [["<ESC>", ':exec g:Lf_py "fileExplManager.quit()"<CR>']],
          \ "Buffer": [["<ESC>", ':exec g:Lf_py "bufExplManager.quit()"<cr>']],
          \ "Mru": [["<ESC>", ':exec g:Lf_py "mruExplManager.quit()"<cr>']],
          \ "Tag": [["<ESC>", ':exec g:Lf_py "tagExplManager.quit()"<cr>']],
          \ "BufTag": [["<ESC>", ':exec g:Lf_py "bufTagExplManager.quit()"<cr>']],
          \ "Function": [["<ESC>", ':exec g:Lf_py "functionExplManager.quit()"<cr>']],
          \ }

  else
    " 不支持 python ，使用 CtrlP 代替
    Plug 'ctrlpvim/ctrlp.vim'

    " 显示函数列表的扩展插件
    Plug 'tacahiroy/ctrlp-funky'

    " 忽略默认键位
    let g:ctrlp_map = ''

    " 模糊匹配忽略
    let g:ctrlp_custom_ignore = {
          \ 'dir':  '\v[\/]\.(git|hg|svn)$',
          \ 'file': '\v\.(exe|so|dll|mp3|wav|sdf|suo|mht)$',
          \ 'link': 'some_bad_symbolic_links',
          \ }

    " 项目标志
    let g:ctrlp_root_markers = ['.project', '.root', '.svn', '.git']
    let g:ctrlp_working_path = 0

    " CTRL+p 打开文件模糊匹配
    noremap <c-p> :CtrlP<cr>

    " CTRL+n 打开最近访问过的文件的匹配
    noremap <c-n> :CtrlPMRUFiles<cr>

    " ALT+p 显示当前文件的函数列表
    noremap <m-p> :CtrlPFunky<cr>

    " ALT+n 匹配 buffer
    noremap <m-n> :CtrlPBuffer<cr>
  endif

  "rg命令 rg真的好用而且还快
 " search word under cursor, the pattern is treated as regex, and enter normal mode directly
  noremap <m-f> :<C-U><C-R>=printf("Leaderf! rg -e %s ", expand("<cword>"))<CR>

  " search word under cursor, the pattern is treated as regex,
  " append the result to previous search results.
  noremap <m-G> :<C-U><C-R>=printf("Leaderf! rg --append -e %s ", expand("<cword>"))<CR>

  " search word under cursor literally only in current buffer
  noremap <m-B> :<C-U><C-R>=printf("Leaderf! rg -F --current-buffer -e %s ", expand("<cword>"))<CR>

  " search word under cursor literally in all listed buffers
  noremap <m-D> :<C-U><C-R>=printf("Leaderf! rg -F --all-buffers -e %s ", expand("<cword>"))<CR>

  " the same as above
  noremap <Leader>a :<C-U><C-R>=printf("Leaderf! rg -e %s -g *.{h,cpp}", expand("<cword>"))<CR>
endif

"----------------------------------------------------------------------
" python mode
"----------------------------------------------------------------------
if index(g:bundle_group, 'python-mode') >= 0
  " python IDE
  "Plug 'python-mode/python-mode', {'for': 'py', 'branch': 'develop' }

  " python-mode 设置
  let g:pymode_python = 'python3'
  " 之后查查rope是做什么的 打开ycm的build.py时 特别卡 先关掉
  let g:pymode_rope = 1

  " 显示python文档
  let g:pymode_doc = 1
  let g:pymode_doc_key = "K"

  " 暂时先关闭pymode的lint检查 一直报错
  let g:pymode_lint = 0

  " 语法高亮
  let g:pymode_syntax = 1
  let g:pymode_syntax_all = 1

  " 查找定义时使用新窗口
  let g:pymode_rope_goto_definition_cmd = 'vnew'
endif

"----------------------------------------------------------------------
" c/c++ customer config
"----------------------------------------------------------------------
if index(g:bundle_group, 'cplusplus') >= 0
  " auto format c++ 默认使用llvm google风格
  Plug 'Chiel92/vim-autoformat', {'for': ['c', 'cpp']}

  " 头文件 cpp切换
  Plug 'CodingdAwn/a.vim', {'for': ['c', 'cpp']}

  " 设置autoformat快捷键
  noremap <F3> :Autoformat<CR>
endif

"----------------------------------------------------------------------
" translator
"----------------------------------------------------------------------
if index(g:bundle_group, 'translator') >= 0
  Plug 'voldikss/vim-translate-me'

  " Echo translation in the cmdline
  nmap <silent> <Leader>tt <Plug>Translate
  vmap <silent> <Leader>tt <Plug>TranslateV
  " Display translation in a window
  nmap <silent> <Leader>tw <Plug>TranslateW
  vmap <silent> <Leader>tw <Plug>TranslateWV
  " Replace the text with translation
  nmap <silent> <Leader>tr <Plug>TranslateR
  vmap <silent> <Leader>tr <Plug>TranslateRV
  " Translate the text in clipboard
  nmap <silent> <Leader>tx <Plug>TranslateX

  " proxy 走代理还得装python的库
  " let g:translator_proxy_url = 'socks5://127.0.0.1:1080'

  " default engine
  let g:translator_default_engines = ['youdao']

endif

"----------------------------------------------------------------------
" coc
"----------------------------------------------------------------------
if index(g:bundle_group, 'coc') >= 0
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
	let g:coc_global_extensions = ['coc-json', 'coc-snippets']
 
  " TextEdit might fail if hidden is not set.
  set hidden

  " Give more space for displaying messages.
  "set cmdheight=2
  
  " ************* for snippets ***************
  " Use <C-l> for trigger snippet expand.
  imap <c-l> <Plug>(coc-snippets-expand)
  
  " Use <C-j> for select text for visual placeholder of snippet.
  vmap <c-j> <Plug>(coc-snippets-select)
  
  " Use <C-j> for jump to next placeholder, it's default of coc.nvim
  let g:coc_snippet_next = '<c-j>'
  
  " Use <C-k> for jump to previous placeholder, it's default of coc.nvim
  let g:coc_snippet_prev = '<c-k>'
  
  " Use <C-j> for both expand and jump (make expand higher priority.)
  imap <c-j> <Plug>(coc-snippets-expand-jump)
  
  " Use <leader>x for convert visual selected code to snippet
  xmap <leader>x  <Plug>(coc-convert-snippet)
  inoremap <silent><expr> <TAB>
        \ pumvisible() ? coc#_select_confirm() :
        \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ coc#refresh()
  
  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction
  
  let g:coc_snippet_next = '<tab>'
  " ************* for snippets ***************

  " Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
  " delays and poor user experience.
  set updatetime=300

  " Don't pass messages to |ins-completion-menu|.
  set shortmess+=c

  " Always show the signcolumn, otherwise it would shift the text each time
  " diagnostics appear/become resolved.
  set signcolumn=yes

  " Use tab for trigger completion with characters ahead and navigate.
  " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
  " other plugin before putting this into your config.
  "inoremap <silent><expr> <TAB>
  "      \ pumvisible() ? "\<C-n>" :
  "      \ <SID>check_back_space() ? "\<TAB>" :
  "      \ coc#refresh()
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

  " Use <c-space> to trigger completion.
  inoremap <silent><expr> <c-space> coc#refresh()

  " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
  " position. Coc only does snippet and additional edit on confirm.
  if has('patch8.1.1068')
    " Use `complete_info` if your (Neo)Vim version supports it.
    inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
  else
    imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
  endif

  " Use `[g` and `]g` to navigate diagnostics
  nmap <silent> [g <Plug>(coc-diagnostic-prev)
  nmap <silent> ]g <Plug>(coc-diagnostic-next)

  " GoTo code navigation.
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)

  nnoremap <silent> <leader>gv :call <SID>definition_other_window('vsplit')<CR>
  nnoremap <silent> <leader>gh :call <SID>definition_other_window('split')<CR>
  function! s:definition_other_window(win_split) abort
    if winnr('$') >= 4 || (winwidth(0) - (max([len(line('$')), &numberwidth-1]) + 1)) < 110
      exec "normal \<Plug>(coc-definition)"
    else
      exec a:win_split
      exec "normal \<Plug>(coc-definition)"
    endif
  endfunction

  " Use K to show documentation in preview window.
  nnoremap <silent> K :call <SID>show_documentation()<CR>

  function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    else
      call CocAction('doHover')
    endif
  endfunction

  " Highlight the symbol and its references when holding the cursor.
  autocmd CursorHold * silent call CocActionAsync('highlight')

  " Symbol renaming.
  nmap <leader>or <Plug>(coc-rename)

  " Formatting selected code.
  xmap <leader>os  <Plug>(coc-format-selected)
  nmap <leader>os  <Plug>(coc-format-selected)

  augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder.
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  augroup end

  " Applying codeAction to the selected region.
  " Example: `<leader>aap` for current paragraph
  xmap <leader>oa  <Plug>(coc-codeaction-selected)
  nmap <leader>oa  <Plug>(coc-codeaction-selected)

  " Remap keys for applying codeAction to the current line.
  nmap <leader>oc  <Plug>(coc-codeaction)
  " Apply AutoFix to problem on the current line.
  nmap <leader>of  <Plug>(coc-fix-current)

  " Introduce function text object
  " NOTE: Requires 'textDocument.documentSymbol' support from the language server.
  xmap if <Plug>(coc-funcobj-i)
  xmap af <Plug>(coc-funcobj-a)
  omap if <Plug>(coc-funcobj-i)
  omap af <Plug>(coc-funcobj-a)

  " Use <TAB> for selections ranges.
  " NOTE: Requires 'textDocument/selectionRange' support from the language server.
  " coc-tsserver, coc-python are the examples of servers that support it.
  nmap <silent> <TAB> <Plug>(coc-range-select)
  xmap <silent> <TAB> <Plug>(coc-range-select)

  " Add `:Format` command to format current buffer.
  command! -nargs=0 Format :call CocAction('format')

  " Add `:Fold` command to fold current buffer.
  command! -nargs=? Fold :call     CocAction('fold', <f-args>)

  " Add `:OR` command for organize imports of the current buffer.
  command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

  " Add (Neo)Vim's native statusline support.
  " NOTE: Please see `:h coc-status` for integrations with external plugins that provide custom statusline: lightline.vim, vim-airline.
  set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

  " Mappings using CoCList:
  " Show all diagnostics.
  nnoremap <silent> <leader>od  :<C-u>CocList diagnostics<cr>
  " Manage extensions.
  nnoremap <silent> <leader>oe  :<C-u>CocList extensions<cr>
  " Show commands.
  nnoremap <silent> <leader>om  :<C-u>CocList commands<cr>
  " Find symbol of current document.
  nnoremap <silent> <leader>oo  :<C-u>CocList outline<cr>
  " Search workspace symbols.
  "nnoremap <silent> <leader>os :<C-u>CocList -I symbols<cr>
  " Do default action for next item.
  nnoremap <silent> <leader>oj  :<C-u>CocNext<CR>
  " Do default action for previous item.
  nnoremap <silent> <leader>ok  :<C-u>CocPrev<CR>
  " Resume latest coc list.
  nnoremap <silent> <leader>op  :<C-u>CocListResume<CR>

  " unmap ctrl i, it's previous location
  if mapcheck("<c-i>") != ''
    unmap <c-i>
  endif

  " json syntax correct
  autocmd FileType json syntax match Comment +\/\/.\+$+ 
endif

"----------------------------------------------------------------------
" c# and unity customer config
"----------------------------------------------------------------------
if index(g:bundle_group, 'unity') >= 0
  " vim omnicompletion for c#
  Plug 'OmniSharp/omnisharp-vim', { 'for': 'cs' }
  
  " Note: this is required for the plugin to work
  filetype indent plugin on
  
  " Use the stdio OmniSharp-roslyn server
  let g:OmniSharp_server_stdio = 1

  if has('patch-8.1.1880')
    set completeopt=longest,menuone,popuphidden
    " Highlight the completion documentation popup background/foreground the same as
    " the completion menu itself, for better readability with highlighted
    " documentation.
    set completepopup=highlight:Pmenu,border:off
  else
    set completeopt=longest,menuone,preview
    " Set desired preview window height for viewing documentation.
    set previewheight=5
  endif

  " Set the type lookup function to use the preview window instead of echoing it
  let g:OmniSharp_typeLookupInPreview = 0
  
  " Timeout in seconds to wait for a response from the server
  let g:OmniSharp_timeout = 5
  
  if has('unix')
    let g:OmniSharp_server_use_mono = 1
  endif

  let g:OmniSharp_highlight_groups = {
  \ 'LocalName': 'Text',
  \}
  " Fetch full documentation during omnicomplete requests.
  " By default, only Type/Method signatures are fetched. Full documentation can
  " still be fetched when you need it with the :OmniSharpDocumentation command.
  let g:omnicomplete_fetch_full_documentation = 1
  
  " Set desired preview window height for viewing documentation.
  " You might also want to look at the echodoc plugin.
  set previewheight=5
  
  " Tell ALE to use OmniSharp for linting C# files, and no other linters.
  let g:ale_linters.cs += ['OmniSharp']
  "let g:ale_linters = { 'cs': ['OmniSharp'] }
  
  " Update semantic highlighting on BufEnter, InsertLeave and TextChanged
  let g:OmniSharp_highlight_types = 2
  
  augroup omnisharp_commands
    autocmd!
  
    " Show type information automatically when the cursor stops moving.
    " Note that the type is echoed to the Vim command line, and will overwrite
    " any other messages in this space including e.g. ALE linting messages.
    autocmd CursorHold *.cs OmniSharpTypeLookup
  
    " The following commands are contextual, based on the cursor position.
    autocmd FileType cs nnoremap <buffer> gd :OmniSharpGotoDefinition<CR>
    autocmd FileType cs nnoremap <buffer> gt :OmniSharpFindImplementations<CR>
    autocmd FileType cs nnoremap <buffer> gs :OmniSharpFindSymbol<CR>
    autocmd FileType cs nnoremap <buffer> gu :OmniSharpFindUsages<CR>
  
    " Finds members in the current buffer
    autocmd FileType cs nnoremap <buffer> <Leader>fm :OmniSharpFindMembers<CR>

    autocmd FileType cs nnoremap <buffer> <Leader>fx :OmniSharpFixUsings<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>ft :OmniSharpTypeLookup<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>fd :OmniSharpDocumentation<CR>
    autocmd FileType cs nnoremap <buffer> <C-\> :OmniSharpSignatureHelp<CR>
    autocmd FileType cs inoremap <buffer> <C-\> <C-o>:OmniSharpSignatureHelp<CR>

    " Navigate up and down by method/property/field
    autocmd FileType cs nnoremap <buffer> <C-k> :OmniSharpNavigateUp<CR>
    autocmd FileType cs nnoremap <buffer> <C-j> :OmniSharpNavigateDown<CR>
 
    " Find all code errors/warnings for the current solution and populate the quickfix window
    autocmd FileType cs nnoremap <buffer> <Leader>cc :OmniSharpGlobalCodeCheck<CR>
      "
    " Contextual code actions (uses fzf, CtrlP or unite.vim when available)
    autocmd FileType cs nnoremap <Leader>fa :OmniSharpGetCodeActions<CR>
    " Run code actions with text selected in visual mode to extract method
    autocmd FileType cs xnoremap <Leader>fa :call OmniSharp#GetCodeActions('visual')<CR>
    
    " Rename with dialog
    autocmd FileType cs nnoremap <Leader>fr :OmniSharpRename<CR>
    "nnoremap <F2> :OmniSharpRename<CR>
    " Rename without dialog - with cursor on the symbol to rename: `:Rename newname`
    command! -nargs=1 Rename :call OmniSharp#RenameTo("<args>")
    
    autocmd FileType cs nnoremap <Leader>ff :OmniSharpCodeFormat<CR>
    
    " Start the omnisharp server for the current solution
    autocmd FileType cs noremap <Leader>fs :OmniSharpStartServer<CR>
    autocmd FileType cs noremap <Leader>fp :OmniSharpStopServer<CR>
    autocmd FileType cs noremap <Leader>fe :OmniSharpHighlightEcho<CR>
  augroup END
  
  " Enable snippet completion
  let g:OmniSharp_want_snippet=1
endif

"----------------------------------------------------------------------
" some web language
"----------------------------------------------------------------------
if index(g:bundle_group, 'web') >= 0
  "Plug 'posva/vim-vue'
  
  " highlight plugin
  "Plug 'StanAngeloff/php.vim'
  "Plug 'phpactor/phpactor', {'for': 'php', 'branch': 'master', 'do': 'composer install --no-dev -o'}
endif

"----------------------------------------------------------------------
" go
"----------------------------------------------------------------------
if index(g:bundle_group, 'go') >= 0
  Plug 'fatih/vim-go', {'for': 'go', 'do': ':GoUpdateBinaries' }

  " go debuger
  Plug 'sebdah/vim-delve', {'for': 'go'}

  " 使用coc的map代替
  let g:go_def_mapping_enabled = 0

  " highlight
  let g:go_highlight_types = 1
  let g:go_highlight_fields = 1
  let g:go_highlight_functions = 1
  let g:go_highlight_function_calls = 1
  let g:go_highlight_operators = 1
  let g:go_highlight_extra_types = 1
  let g:go_highlight_build_constraints = 1

  " remap
  autocmd FileType go nnoremap <buffer> <a-m> :GoDecls<CR>
  autocmd FileType go nnoremap <buffer> <a-n> :GoDeclsDir<CR>

  " delve
  let g:delve_backend = "lldb"

  " some config
endif

"----------------------------------------------------------------------
" vim wiki
"----------------------------------------------------------------------
if index(g:bundle_group, 'go') >= 0
  Plug 'vimwiki/vimwiki'
  " remap
  autocmd FileType wiki,vimwiki nnoremap <buffer> <leader>wd :VimwikiToggleListItem<CR>
endif

"----------------------------------------------------------------------
" vim debugger
"----------------------------------------------------------------------
if index(g:bundle_group, 'debugger') >= 0
  Plug 'puremourning/vimspector'
  let g:vimspector_enable_mappings = 'VISUAL_STUDIO'
  let g:vimspector_install_gadgets = [ 'vscode-go', 'vscode-cpptools' ]
endif

"----------------------------------------------------------------------
" vim script by dawn
"----------------------------------------------------------------------
if index(g:bundle_group, 'myself') >= 0
  " memo 
  " 使用vimwiki 代替
  "Plug 'CodingdAwn/vim-memo'

  " file header auto generate
  Plug 'CodingdAwn/vim-header'
  let g:header_auto_add_header=0
  let g:header_field_modified_timestamp=0
  let g:header_field_modified_by=0
  let g:header_field_author='dAwn_'
endif

"----------------------------------------------------------------------
" 结束插件安装
"----------------------------------------------------------------------
call plug#end()
