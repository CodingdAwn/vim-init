call which_key#register('<Space>', "g:which_key_map")
nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
vnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
set timeoutlen=500

let g:which_key_map = {}

" =======================================================
" OmniSharp
" =======================================================
let g:which_key_map.c = {
      \ 'name' : '+omnisharp',
      \ 'a' : 'code action',
      \ 'd' : 'documentation',
      \ 'e' : 'highlight echo',
      \ 'r' : 'rename',
      \ 's' : 'start server',
      \ 'p' : 'stop server',
      \ 't' : 'type look up',
      \ 'f' : 'code format',
      \ 'm' : 'find members in the current buffer',
      \ 'x' : 'fix using',
      \ }

" =======================================================
" coc
" =======================================================
let g:which_key_map.o = {
      \ 'name' : 'coc',
      \ 'd' : 'diagostics',
      \ 'e' : 'extensions',
      \ 'm' : 'commands',
      \ 'o' : 'outline',
      \ 'r' : 'rename',
      \ 's' : 'symbols',
      \ 'f' : 'coc formate in visual mode',
      \ 'j' : 'coc next',
      \ 'k' : 'coc prev',
      \ 'p' : 'coc list resume',
      \ }

" =======================================================
" leaderf rg查找
" =======================================================
"let g:which_key_map.r = {
"      \ 'name' : '+ripgrep',
"      \ 'f' : 'regex search'    ,
"      \ 'g' : 'regex search append result to previous results',
"      \ 'b' : 'search in current buffer',
"      \ 'd' : 'search in all list buffer',
"      \ 'l' : 'regex search stay open',
"      \ 'o' : 'reopen the window',
"      \ 'a' : 'regex search in *.h *.cpp',
"      \ }
let g:which_key_map.r = {'name' : 'ripgrep'}
let g:which_key_map.r.f = 'which_ignore'

" =======================================================
" leaderf gtags查找
" =======================================================
let g:which_key_map.g = {
      \ 'name' : '+leaderf gtags',
      \ 'c' : 'find calling this func',
      \ 't' : 'find text',
      \ 'e' : 'find use egrep',
      \ 'f' : 'find file',
      \ 'i' : 'find include',
      \ 'r' : 'show reference to a symbol which has definithions',
      \ 'd' : 'find this function called',
      \ 's' : 'show reference to a symbol which has no definithions',
      \ 'g' : 'find definition',
      \ 'a' : 'find assign',
      \ 'z' : 'find with ctag',
      \ 'k' : 'kill gscope',
      \ }

" =======================================================
" tab operator and translate
" =======================================================
let g:which_key_map.t = {
      \ 'name' : '+tab & translate',
      \ 'c' : 'tab new'    ,
      \ 'l' : 'call Tab_MoveLeft',
      \ 'n' : 'tab next',
      \ 'o' : 'tab only',
      \ 'p' : 'tab prev',
      \ 'q' : 'tab close',
      \ 'r' : 'vim-translate-me replace current word',
      \ 't' : 'vim-translate-me current word with message',
      \ 'w' : 'vim-translate-me float window',
      \ 'x' : 'vim-translate-me translate clipboard text',
      \ }

" =======================================================
" buffers
" =======================================================
let g:which_key_map.b = {
      \ 'name' : '+buffers',
      \ 'n' : 'next buffer'    ,
      \ 'p' : 'previous buffer',
      \ }

" =======================================================
" a.vim
" =======================================================
let g:which_key_map.i = {
      \ 'name' : 'a.vim',
      \ }

