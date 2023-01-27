syntax enable
set termguicolors
set smartcase
set ignorecase
let g:loaded_python3_provider = 0
let g:loaded_ruby_provider = 0
let g:loaded_node_provider = 0
let g:loaded_perl_provider = 0
" highlight Pmenu ctermfg=grey ctermbg=black
autocmd Signal SIGUSR1 quit
" set background=dark
set background=light

let mapleader = ' '
let maplocalleader = ' '
set noswapfile
" Enable persistent undo so that undo history persists across vim sessions
set undofile
set undodir=~/.vim/undo

set mouse=a
set nomodeline
set modelines=0
set number relativenumber
set clipboard=unnamed
set encoding=utf-8
set expandtab
let tabstop=4
set shiftwidth=4
set splitbelow
set splitright
syntax on
" pop-up menu options
highlight Pmenu guibg=NONE
set wildoptions=pum
" set pumblend=10
set foldcolumn=0
set nocursorline
set ttyfast
set autowrite
set autoread
" increase the history limit of
set history=10000
" No annoying sound on errors
set noerrorbells
set novisualbell
set grepprg=rg
set updatetime=50
set selection=inclusive
" Display 5 lines above/below the cursor when scrolling with a mouse.
set scrolloff=5
" Highlight matching pairs of brackets. Use the '%' character to jump between pairs
set matchpairs+=<:>
highlight Comment cterm=italic
highlight clear SignColumn
" Use system clipboard
if has('unnamedplus')
  set clipboard=unnamed,unnamedplus
endi
filetype plugin indent on

" Shared statusline
set laststatus=3
" Reset
set statusline=
set statusline=%#LineNr#%F:%l:%c:%o%=\ │\ %p%%\ │\ %{strftime('%c')} 
func Refresh_Statusline(timer)
  set statusline=
  set statusline=%#LineNr#%F:%l:%c:%o%=\ │\ %p%%\ │\ %{strftime('%c')} 
endfunc
call timer_start(1000, 'Refresh_Statusline', {'repeat': -1})


" Make split bar prettier
set fillchars=stlnc:⚊,vert:\│ 
highlight VertSplit cterm=NONE gui=NONE
highlight WinSeparator cterm=NONE gui=NONE
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

nmap <c-k> <C-w>k
nmap <c-j> <C-w>j

nnoremap <leader>cp :let @+ = expand("%:p")<CR>
nnoremap <leader>cr :let @+ = expand("%")<CR>
nnoremap <leader>cf :let @+ = expand("%:t")<CR>
nnoremap <leader>e :vs ~/.vimrc<CR>

nnoremap <leader>yy "+y<CR>

set rtp+=/usr/local/opt/fzf
let g:fzf_preview_window = ['right:50%', 'ctrl-/']
nnoremap <c-p> :FZF<cr>

nnoremap <S-c-R> :source ~/.vimrc<cr>
nnoremap <c-g> :lua vim.fn['fzf#vim#grep']('rg --column --line-number --no-heading --color=always -w -- ' .. vim.fn['expand']('<cword>'), 1, vim.fn['fzf#vim#with_preview'](),0) <cr>
nnoremap <c-_> :GFiles<cr>
nnoremap <leader>d :GFiles?<cr>

nmap <leader>l :nohl<CR>:lclose<CR>:cclose<CR>
let g:indentLine_char = '┊'
let g:gitgutter_enabled = 1


autocmd BufRead,BufNewFile *.nasm setfiletype asm
autocmd BufRead,BufNewFile *.ice setfiletype cpp


" Coc config
" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Autoformat
augroup mygroup
  autocmd!
  autocmd BufWritePost *.json,*.c,*.cpp,*.h,*.rs call CocAction('format')
augroup end
"
" Autoformat js/ts
autocmd FileType typescript setlocal formatprg=prettier\ --parser\ typescript
autocmd FileType javascript setlocal formatprg=prettier\ --parser\ typescript
augroup mygroup
  autocmd!
  autocmd BufWritePost *.js,*.jsx,*.ts,*.tsx call jobstart(['deno', 'fmt',  expand('%:p')], {})
augroup end

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

set signcolumn=yes

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"


" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
" xmap <leader>f  <Plug>(coc-format-selected)
" nmap <leader>f  <Plug>(coc-format-selected)

" augroup mygroup
"   autocmd!
"   " Setup formatexpr specified filetype(s).
"   autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
"   " Update signature help on jump placeholder.
"   autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
" augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
" xmap <leader>a  <Plug>(coc-codeaction-selected)
" nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
" nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
" xmap if <Plug>(coc-funcobj-i)
" omap if <Plug>(coc-funcobj-i)
" xmap af <Plug>(coc-funcobj-a)
" omap af <Plug>(coc-funcobj-a)
" xmap ic <Plug>(coc-classobj-i)
" omap ic <Plug>(coc-classobj-i)
" xmap ac <Plug>(coc-classobj-a)
" omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
" command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
" command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
" command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings using CoCList:
" Show all diagnostics.
" nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
" nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
" nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
" nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
" nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
" nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
" nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
" nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
" Coc config end

" let g:tmux_navigator_no_mappings = 1
" nnoremap <silent> <M-h> :TmuxNavigateLeft<cr>
" nnoremap <silent> <M-j> :TmuxNavigateDown<cr>
" nnoremap <silent> <M-k> :TmuxNavigateUp<cr>
" nnoremap <silent> <M-l> :TmuxNavigateRight<cr>
" nnoremap <silent> <M-j> :TmuxNavigatePrevious<cr>

let g:go_doc_keywordprg_enabled = 0


function! s:ncopy_gitlab_url()
  let file_path = expand('%:p')
  let line=line('.')
   call jobstart(['/Users/pgaultier/code/c/nvim/gitlab-url-copy', file_path, line], {})
endfunction

function! s:vcopy_gitlab_url(line_start, line_end)
  let file_path = expand('%:p')
   call jobstart(['/Users/pgaultier/code/c/nvim/gitlab-url-copy', file_path, a:line_start, a:line_end], {})
endfunction

nmap <leader>x :call <SID>ncopy_gitlab_url()<cr>
command! -nargs=0 -range VGitlabUrlCopy :call <SID>vcopy_gitlab_url(<line1>, <line2>)
vnoremap <leader>x :VGitlabUrlCopy<cr>

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

command! -nargs=0 -range VJqFmt :call <SID>v_jq_fmt(<line1>, <line2>)
vnoremap <leader>j :VJqFmt<cr>


" Plugins
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin('~/.vim/plugged')

Plug 'https://github.com/mbbill/undotree'
Plug 'https://github.com/tpope/vim-abolish'
Plug 'https://github.com/tpope/vim-commentary'
Plug 'https://github.com/tpope/vim-eunuch'
Plug 'https://github.com/tommcdo/vim-exchange'
Plug 'https://github.com/airblade/vim-gitgutter'
Plug 'https://github.com/kana/vim-operator-user'
" Plug 'https://github.com/rhysd/vim-clang-format'
Plug 'git://github.com/tpope/vim-repeat.git'
Plug 'https://github.com/tpope/vim-unimpaired'
Plug 'wellle/targets.vim'
Plug 'https://github.com/tpope/vim-surround'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sheerun/vim-polyglot'
Plug 'fatih/vim-go'
Plug 'https://github.com/tpope/vim-fugitive'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'https://github.com/tpope/vim-abolish'
Plug 'morhetz/gruvbox'
" Plug 'neovim/nvim-lsp'
" Plug 'sakhnik/nvim-gdb', { 'do': ':!./install.sh' }

" Override :Rg
command! -bang -nargs=* -complete=file Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case --hidden '. <q-args>, 1,
  \   fzf#vim#with_preview(), <bang>0)

" Initialize plugin system
call plug#end()

colorscheme gruvbox
