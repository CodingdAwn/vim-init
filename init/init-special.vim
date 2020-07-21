"======================================================================
"
" init-special.vim - 我自己的一些测试和处理
"
" Created by dAwn_ on 2020/01/09
"
"======================================================================

"----------------------------------------------------------------------
" 快速打开各种配置文件
"----------------------------------------------------------------------

" 先设置一些快捷键吧 
" 因为现在vim使用的还不熟练 所以经常出现一些vim的问题 经常想要迅速打开某个vim
" 配置文件 

let s:todo_list_path = '~/.vim/bundles/vim-memo/todo_list'

function ToVimPlug()
  let dest_path = 'e ' . '~/.vim/vim-init/init/init-plugins.vim'
  exec dest_path
endfunction

function ToZsh()
  let dest_path = 'e ' . '~/.zshrc'
  exec dest_path
endfunction

function ToTmux()
  let dest_path = 'e ' . '~/.tmux.conf'
  exec dest_path
endfunction

" where is my todo memo directory? how to find it ----fixed
function ToDoList()
  let dest_path = 'e ' . s:todo_list_path . '/memo.md'
  exec dest_path
endfunction

let s:arg_vim_plug = '--vimplug'
let s:arg_zsh = '--zsh'
let s:arg_tumx = '--tmux'
let s:arg_todo = '--todo'

function OpenParseArguments(ArgLead, CmdLine, CursorPos) abort
  return [s:arg_vim_plug, s:arg_zsh, s:arg_tumx, s:arg_todo]
endfunction

function OpenWithArgument(arg)
  if a:arg == s:arg_vim_plug
    call ToVimPlug()
  elseif a:arg == s:arg_zsh
    call ToZsh()
  elseif a:arg == s:arg_tumx
    call ToTmux()
  elseif a:arg == s:arg_todo
    call ToDoList()
  endif
endfunction

command! -nargs=1 -bang -complete=customlist,OpenParseArguments OpenCustomFile call OpenWithArgument(<q-args>)

"----------------------------------------------------------------------
" 一些快捷操作
"----------------------------------------------------------------------

"----------------------------------------------------------------------
" 将windows换行符转换成unix的 ctrl-v ctrl-m打出^M"
" ----------------------------------------------------------------------
function TLF()
  exec ':%s/$//g'
endfunction
command! -nargs=0 -bang TransferLF call TLF()

"----------------------------------------------------------------------
" 在当前光标下输出时间
" ----------------------------------------------------------------------
function PutTheDate()
  let l:date_string = strftime('%Y-%m-%d')
  exec ':normal! a' . l:date_string . "\<ESC>"
endfunction
command! -nargs=0 -bang PutDate call PutTheDate()

"----------------------------------------------------------------------
" change to transparent
" ----------------------------------------------------------------------
function ToTransparent()
  hi! Normal ctermbg=NONE guibg=NONE
endfunction
command! -nargs=0 -bang Transparent call ToTransparent()

