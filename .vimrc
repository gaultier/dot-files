"---------- Coc begin ----------
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~" '\s'
endfunction

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"


" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"


" Use K to show documentation in preview window.
" TODO: nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

"---------- Coc end ----------

function! s:vcopy_git_webui_url(line_start, line_end)
  let file_path = expand('%:p')
   call jobstart(['ado-link', file_path, a:line_start, a:line_end+1], {})
endfunction

" TODO: nmap <leader>x :call <SID>ncopy_git_webui_url()<cr>
" TODO: command! -nargs=0 -range VGitWebUiUrlCopy :call <SID>vcopy_git_webui_url(<line1>, <line2>)
" vnoremap <leader>x :VGitWebUiUrlCopy<cr>

" " Format visual selection with jq
let g:jq_fmt_ns = nvim_create_namespace('jq_fmt')
function! s:v_jq_fmt(line_start, line_end)
  let marks = nvim_buf_get_extmarks(0, g:jq_fmt_ns, 0, -1, {})
  for [mark_id, row, col] in marks 
    call nvim_buf_del_extmark(0, g:jq_fmt_ns, mark_id)
  endfor

  let input = getline(a:line_start, a:line_end)

  let output = system('jq -M', input)

  if v:shell_error == 0
      for i in range(a:line_start, a:line_end, 1)
        delete
      endfor
      let lines = split(output, '\n')
      " Need `-1` in case we are at the end of the file
      call append(a:line_start-1, lines)
  else 
      call nvim_buf_set_extmark(0, g:jq_fmt_ns, a:line_start-1, 0, {'virt_text': [['jq failed: ' . output, 'ErrorMsg']], 'virt_text_pos': 'eol'})
  endif
endfunction
" TODO: command! -nargs=0 -range VJqFmt :call <SID>v_jq_fmt(<line1>, <line2>)
vnoremap <leader>j :VJqFmt<cr>


" Plugins
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


" Override :Rg
command! -bang -nargs=* -complete=file Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case --hidden '. <q-args>, 1,
  \   fzf#vim#with_preview(), <bang>0)
