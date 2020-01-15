nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
nnoremap <silent> <localleader> :<c-u>WhichKey  ','<CR>

let g:which_key_map = {}

" =======================================================
" 基于gutentags_puls查找
" =======================================================
let g:which_key_map.c = {
      \ 'name' : '+gutentags_plus',
      \ 's' : 'Find this symbol'    ,
      \ 'g' : 'Find this definition',
      \ 'd' : 'Find functions called by this function',
      \ 'c' : 'Find functions calling this function',
      \ 't' : 'Find this text string',
      \ 'e' : 'Find this egrep pattern',
      \ 'f' : 'Find this file',
      \ 'i' : 'Find files #including this file',
      \ 'a' : 'Find places where this symbol is assigned a value',
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
      \ 'r' : 'show reference to a symbol which has definithions'    ,
      \ 'd' : 'show locations of definitions',
      \ 's' : 'show reference to a symbol which has no definithions',
      \ 'g' : 'show all lines which to the <PATTERN>',
      \ 'o' : 'recall last search. if window is closed, reopen it',
      \ 'n' : 'jump to the next result',
      \ 'p' : 'jump to the previous result',
      \ 'u' : 'create tag files if not exists',
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

" 注册
call which_key#register('<Space>', "g:which_key_map")
