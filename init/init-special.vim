"======================================================================
"
" init-special.vim - 我自己的一些测试和处理
"
" Created by dAwn_ on 2020/01/09
"
"======================================================================

"----------------------------------------------------------------------
" 
"----------------------------------------------------------------------

" 先设置一些快捷键吧 
" 因为现在vim使用的还不熟练 所以经常出现一些vim的问题 经常想要迅速打开某个vim
" 配置文件 

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

" where is my memo directory? how to find it
function ToMemo()
  let dest_path = 'e ' . '~/Documents/Documents/memo.md'
  exec dest_path
endfunction

let s:arg_vim_plug = '--vimplug'
let s:arg_zsh = '--zsh'
let s:arg_tumx = '--tmux'
let s:arg_memo '--memo'

function OpenParseArguments(ArgLead, CmdLine, CursorPos) abort
  return [s:arg_vim_plug, s:arg_zsh, s:arg_tumx, s:arg_memo]
endfunction

function OpenWithArgument(arg)
  if a:arg == s:arg_vim_plug
    call ToVimPlug()
  elseif a:arg == s:arg_zsh
    call ToZsh()
  elseif a:arg == s:arg_tumx
    call ToTmux()
  elseif a:arg == s:arg_memo
    call ToMemo()
  endif
endfunction

command! -nargs=1 -bang -complete=customlist,OpenParseArguments OpenCustomFile call OpenWithArgument(<q-args>)
