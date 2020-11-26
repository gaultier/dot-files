let mapleader = '`'
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
set pumblend=30
set foldcolumn=0
set nocursorline
set ttyfast
set autowrite
set autoread
" increase the history limit of
set history=1000
" No annoying sound on errors
set noerrorbells
set novisualbell
set termguicolors
set grepprg=rg
set updatetime=50
set selection=inclusive
" Display 5 lines above/below the cursor when scrolling with a mouse.
set scrolloff=5
" Highlight matching pairs of brackets. Use the '%' character to jump between pairs
set matchpairs+=<:>
highlight Comment cterm=italic
" set 256 color
set t_Co=256
let &t_ut=''
" set terminal gui colors
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
" Use system clipboard
if has('unnamedplus')
  set clipboard=unnamed,unnamedplus
endi
filetype plugin indent on
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
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup



autocmd FileType c,cpp,proto ClangFormatAutoEnable

nnoremap <leader>cp :let @+ = expand("%:p")<CR>
nnoremap <leader>cr :let @+ = expand("%")<CR>
nnoremap <leader>cf :let @+ = expand("%:t")<CR>

nnoremap <leader>yy "+y<CR>

set rtp+=/usr/local/opt/fzf

nnoremap <c-p> :FZF<cr>
nnoremap <c-g> :Rg<cr>

nmap <leader>l :nohl<CR>:lclose<CR>:cclose<CR>
let g:indentLine_char = '┊'
let g:gitgutter_enabled = 1


autocmd BufRead,BufNewFile *.nasm setfiletype asm


let g:rustfmt_autosave = 1

let g:xcodedark_emph_funcs = 0
let g:xcodedark_emph_idents = 0
let g:xcodedark_emph_types = 0

" Coc config
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
" autocmd CursorHold * silent call CocActionAsync('highlight')

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
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

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
Plug 'https://github.com/rhysd/vim-clang-format'
Plug 'git://github.com/tpope/vim-repeat.git'
Plug 'https://github.com/jremmen/vim-ripgrep'
Plug 'https://github.com/christoomey/vim-tmux-navigator'
Plug 'https://github.com/tpope/vim-unimpaired'
Plug 'wellle/targets.vim'
Plug 'https://github.com/tpope/vim-surround'
Plug 'arzg/vim-colors-xcode'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sheerun/vim-polyglot'
Plug 'ziglang/zig.vim'
Plug 'fatih/vim-go'
" Plug 'neovim/nvim-lsp'

" Initialize plugin system
call plug#end()
