source $XDG_CONFIG_HOME/nvim/setjkl.vim

let g:mapleader = "'"

" default mappings
" <C-g> show full path to current buffer
" K show type info

nnoremap <leader>a :Rg<cr>
nnoremap <leader>g :RgFzf<cr>

" add --no-heading 
" to show the file name in fzf preview, 
command!      -bang -nargs=* RgFzf call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case --hidden --follow -- ".shellescape(<q-args>), 1, fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'right:60%'), <bang>0)

au FileType python nmap <A-f> :call Autopep8()<CR>

au FileType go nmap <A-f> :GoFmt<cr>:GoBuild<cr>
" au FileType go nmap <A-f> :call CocAction('runCommand', 'editor.action.organizeImport')<cr>:GoFmt<cr>:GoBuild<cr>

au FileType go nmap <leader>r :GoRename<cr>

" let g:autopep8_max_line_length=120
" autocmd FileType python noremap <buffer> <A-f> :call Autopep8()<CR>
" noremap <A-f> :CocCommand python.runLinting<CR>

" no esc
inoremap jj <esc>
inoremap <C-c> <esc>uu
inoremap <C-q> <esc>
inoremap  <esc> <NOP>
" for the foot pedal
noremap <C-q> :q<esc>

" ,' Surround a word with 'single quotes'
map ,' ysiw'
vmap ,' c'<C-R>"'<ESC>

map ,` ysiw`
vmap ,` c`<C-R>"`<ESC>

map ," ysiw"
vmap ," c`<C-R>""<ESC>

" ,) or ,( Surround a word with (parens)
" The difference is in whether a space is put in
map ,( ysiw(
map ,) ysiw)
vmap ,( c( <C-R>" )<ESC>
vmap ,) c(<C-R>")<ESC>

" ,[ Surround a word with [brackets]
map ,] ysiw]
map ,[ ysiw[
vmap ,[ c[ <C-R>" ]<ESC>
vmap ,] c[<C-R>"]<ESC>

" ,{ Surround a word with {braces}
map ,} ysiw}
map ,{ ysiw{
vmap ,} c{ <C-R>" }<ESC>
vmap ,{ c{<C-R>"}<ESC>

map ,> ysiw>
map ,< ysiw<
vmap ,< c<<C-R>"><ESC>

" replace text inside/around block elements, jump to next block if 
" the cursor is not in one
noremap ci) /)<cr>ci)
noremap ci( /(<cr>ci(
noremap ci{ /{<cr>ci{
noremap ci} /}<cr>ci}
noremap ci[ /[<cr>ci[
noremap ci] /]<cr>ci]
noremap ci[ /[<cr>ci[
noremap ci] /]<cr>ci]
noremap ci< /<<cr>ci<
noremap ci> /><cr>ci>
noremap ci" /"<cr>ci"
noremap ci' /'<cr>ci'
noremap ci` /{<cr>ci`

noremap ca) /)<cr>ca)
noremap ca( /(<cr>ca(
noremap ca{ /{<cr>ca{
noremap ca} /}<cr>ca}
noremap ca[ /[<cr>ca[
noremap ca] /]<cr>ca]
noremap ca[ /[<cr>ca[
noremap ca] /]<cr>ca]
noremap ca< /<<cr>ca<
noremap ca> /><cr>ca>
noremap ca" /"<cr>ca"
noremap ca' /'<cr>ca'
noremap ca` /{<cr>ca`

" yank to clipboard
vnoremap <C-c> "+y
" copy line to clipboard
nnoremap <C-c> "+yy
vnoremap Y "+y$

" when pasting in visual mode, do not put the visual selection in the
" clipboard; keep the clipboard as is
xnoremap <expr> p 'pgv"'.v:register.'y`>'
xnoremap <expr> P 'Pgv"'.v:register.'y`>'

" when changing text, do not yank to clipboard but to register e
nnoremap cw "ecw
nnoremap cW "ecW
nnoremap ce "ece
nnoremap cE "ecE
nnoremap c$ "ec$
nnoremap ct "ect
nnoremap cf "ecf
nnoremap C "eC

" when deleting, yank to register e
" nnoremap d "ed
" when deleting, yank to register e
" noremap x "ex

" fzf.vim
nnoremap <C-p> :Files<cr>
nnoremap <leader>bb :Buffers<cr>
nnoremap <leader>bl :Lines<cr>

" previous/next tab
nnoremap <leader>k :bn<cr>
nnoremap <leader>l :bp<cr>

" 
nnoremap <silent> <leader><leader>t    <Cmd>BufferPick<CR>
nnoremap <silent> <leader><leader>o <Cmd>BufferOrderByDirectory<CR>


" prevent that vim-go overwrites our K mapping
let g:go_doc_keywordprg_enabled = 0
nnoremap K :bn<cr>
nnoremap L :bp<cr>

" copilot-next: <C-[>
" copilot-prev: <C-[>
