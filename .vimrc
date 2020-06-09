let mapleader = '`'
set mouse=a
set nomodeline
set modelines=0
set number relativenumber
set clipboard=unnamed
set encoding=utf-8
set expandtab
let tabstop=4
set shiftwidth=4
syntax on
" colorscheme default

" pop-up menu options
highlight Pmenu guibg=NONE
set wildoptions=pum
set pumblend=30


set foldcolumn=0
set nocursorline
set ttyfast
" Save when running :make
set autowrite
filetype plugin indent on

set termguicolors

" autocmd FileType js,ts,tsx ClangFormatAutoDisable
autocmd FileType c,cpp,proto ClangFormatAutoEnable

nnoremap <leader>cp :let @+ = expand("%:p")<CR>
nnoremap <leader>cr :let @+ = expand("%")<CR>
nnoremap <leader>cf :let @+ = expand("%:t")<CR>

" let g:ycm_server_python_interpreter="/usr/local/bin/python3"
" let g:ycm_confirm_extra_conf = 0
" let g:ycm_use_ultisnips_completer = 0
" let g:ycm_collect_identifiers_from_tags_files = 1
" let g:ycm_autoclose_preview_window_after_completion = 1
" nnoremap <leader>yi  :YcmCompleter GoToInclude<CR>
" nnoremap <leader>yt  :YcmCompleter GetType<CR>
" nnoremap <leader>yg :YcmCompleter GoTo<CR>
" nnoremap <leader>yq :YcmCompleter FixIt<CR>
" nnoremap <leader>yd :YcmDiags<CR>
" nnoremap <leader>cc :cclose<CR>
" nnoremap <leader>co :copen<CR>
nnoremap <leader>yy "+y<CR>

set rtp+=/usr/local/opt/fzf

nnoremap <c-p> :FZF<cr>
nnoremap <c-g> :Rg<cr>

set grepprg=rg
nmap <leader>l :nohl<CR>:lclose<CR>:cclose<CR>
set selection=inclusive
let g:indentLine_char = '┊'

set updatetime=50
let g:gitgutter_enabled = 1

set splitbelow
set splitright

autocmd BufRead,BufNewFile *.nasm setfiletype asm
" autocmd BufRead,BufNewFile nginx.conf setfiletype conf
" autocmd BufRead,BufNewFile *yml* setfiletype yaml
" autocmd BufRead,BufNewFile *.yml.template setfiletype yaml
" autocmd BufRead,BufNewFile *.yaml setfiletype yaml
" autocmd BufRead,BufNewFile *.ts setfiletype javascript
" autocmd BufRead,BufNewFile Dockerfile* setfiletype Dockerfile


" Status bar
set laststatus=2
" Reset
set statusline=
set statusline+=%#LineNr#
set statusline+=\ %f
" Middle separator
set statusline+=\ %=
set statusline+=\ %p%%
set statusline+=\ %l:%c

" Remove split bar
set fillchars=vert:\ 
set fillchars+=stl:\-

let g:rustfmt_autosave = 1

let g:xcodedark_emph_funcs = 0
let g:xcodedark_emph_idents = 0
let g:xcodedark_emph_types = 0

" Coc config
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

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
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
" inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" if has('patch8.1.1068')
"   " Use `complete_info` if your (Neo)Vim version supports it.
"   inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
" else
"   imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" endif

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
  else
    call CocAction('doHover')
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

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
" xmap if <Plug>(coc-funcobj-i)
" xmap af <Plug>(coc-funcobj-a)
" omap if <Plug>(coc-funcobj-i)
" omap af <Plug>(coc-funcobj-a)

" Use <TAB> for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support from the language server.
" coc-tsserver, coc-python are the examples of servers that support it.
" nmap <silent> <TAB> <Plug>(coc-range-select)
" xmap <silent> <TAB> <Plug>(coc-range-select)

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

" Plugins
call plug#begin('~/.vim/plugged')

Plug 'junegunn/fzf'
Plug 'https://github.com/junegunn/fzf.vim'
Plug 'https://github.com/markonm/traces.vim'
Plug 'https://github.com/mbbill/undotree'
Plug 'https://github.com/tpope/vim-abolish'
Plug 'https://github.com/tpope/vim-commentary'
Plug 'https://github.com/tpope/vim-eunuch'
Plug 'https://github.com/tommcdo/vim-exchange'
Plug 'https://github.com/airblade/vim-gitgutter'
Plug 'https://github.com/tommcdo/vim-lion'
Plug 'https://github.com/kana/vim-operator-user'
" Plug 'dense-analysis/ale'
" Plug 'https://github.com/Valloric/YouCompleteMe'
Plug 'https://github.com/rhysd/vim-clang-format'
" Plug 'https://github.com/luochen1990/rainbow'
" Plug 'https://github.com/tpope/vim-fireplace', { 'for': 'clojure' }
" Plug 'https://github.com/venantius/vim-cljfmt', { 'for': 'clojure' }
" Plug 'https://github.com/bhurlow/vim-parinfer.git', { 'for': 'clojure' }
Plug 'git://github.com/tpope/vim-repeat.git'
Plug 'https://github.com/jremmen/vim-ripgrep'
Plug 'https://github.com/christoomey/vim-tmux-navigator'
Plug 'https://github.com/tpope/vim-unimpaired'
Plug 'wellle/targets.vim'
Plug 'https://github.com/tpope/vim-surround'
Plug 'arzg/vim-colors-xcode'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sheerun/vim-polyglot'
Plug 'mhinz/vim-startify'
" Plug 'neovim/nvim-lsp'

" Initialize plugin system
call plug#end()
