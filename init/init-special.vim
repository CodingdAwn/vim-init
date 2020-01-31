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
  let vim_init_plug_path = 'e ' . '~/.vim/vim-init/init/init-plugins.vim'
  exec vim_init_plug_path
endfunction

function ToZsh()
  let vim_init_plug_path = 'e ' . '~/.zshrc'
  exec vim_init_plug_path
endfunction

function ToTmux()
  let vim_init_plug_path = 'e ' . '~/.tmux.conf'
  exec vim_init_plug_path
endfunction

let s:arg_vim_plug = '--vimplug'
let s:arg_zsh = '--zsh'
let s:arg_tumx = '--tmux'

function OpenParseArguments(ArgLead, CmdLine, CursorPos) abort
  return [s:arg_vim_plug, s:arg_zsh, s:arg_tumx]
endfunction

function OpenWithArgument(arg)
  if a:arg == s:arg_vim_plug
    call ToVimPlug()
  elseif a:arg == s:arg_zsh
    call ToZsh()
  else
    call ToTmux()
  endif
endfunction

command! -nargs=1 -bang -complete=customlist,OpenParseArguments OpenCustomFile call OpenWithArgument(<q-args>)

