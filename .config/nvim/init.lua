
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.fzf_preview_window = {'right:50%', 'ctrl-/'}
vim.g.indentLine_char = '┊'
vim.g.gitgutter_enabled = 1
vim.g.go_doc_keywordprg_enabled = 0

vim.keymap.set('n', '<leader>e', ':vs ~/.vimrc<CR>')
vim.keymap.set('n', '<leader>s', ':source ~/.vimrc<CR>')
vim.keymap.set('n', '<leader>el', ':vs ~/.config/nvim/init.lua<CR>')
vim.keymap.set('n', '<leader>sl', ':luafile ~/.config/nvim/init.lua<CR>')
vim.keymap.set('n', '<c-p>', ':FZF<CR>')
vim.keymap.set('n', '<leader>cp', ':let @+ = expand("%:p")<CR>')
vim.keymap.set('n', '<leader>cr', ':let @+ = expand("%")<CR>')
vim.keymap.set('n', '<leader>cf', ':let @+ = expand("%:t")<CR>')
vim.keymap.set('n', '<c-k>', '<C-w>k')
vim.keymap.set('n', '<c-j>', '<C-w>j')
vim.keymap.set('n', '<c-h>', '<C-w>h')
vim.keymap.set('n', '<c-l>', '<C-w>l')
vim.keymap.set('n', '<c-g>', ':Rg --column --line-number --no-heading --color=always -w -- ' .. vim.fn['expand']('<cword>') .. '<cr>')
vim.keymap.set('n', '<leader>l', ':nohl<CR>:lclose<CR>:cclose<CR>')
vim.keymap.set('n', '[g', '<Plug>(coc-diagnostic-prev)')
vim.keymap.set('n', ']g', '<Plug>(coc-diagnostic-next)')
vim.keymap.set('n', 'gd', '<Plug>(coc-definition)')
vim.keymap.set('n', 'gy', '<Plug>(coc-type-definition)')
vim.keymap.set('n', 'gi', '<Plug>(coc-implementation)')
vim.keymap.set('n', 'gr', '<Plug>(noc-references)')
vim.keymap.set('n', '<leader>rn', '<Plug>(coc-rename)')
vim.keymap.set('n', '<leader>qf', '<Plug>(coc-fix-current)')

------------------- Plug
local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.vim/plugged')

Plug 'https://github.com/mbbill/undotree'
Plug 'https://github.com/tpope/vim-abolish'
Plug 'https://github.com/tpope/vim-commentary'
Plug 'https://github.com/tpope/vim-eunuch'
Plug 'https://github.com/tommcdo/vim-exchange'
Plug 'https://github.com/airblade/vim-gitgutter'
Plug 'https://github.com/kana/vim-operator-user'
Plug 'https://github.com/tpope/vim-unimpaired'
Plug 'wellle/targets.vim'
Plug 'https://github.com/tpope/vim-surround'
Plug('neoclide/coc.nvim', {branch = 'release'})
Plug 'sheerun/vim-polyglot'
Plug 'fatih/vim-go'
Plug 'https://github.com/tpope/vim-fugitive'
Plug('junegunn/fzf', { 
  ['do'] = function()
	vim.call('fzf#install()')
  end
})
Plug 'junegunn/fzf.vim'
Plug 'https://github.com/tpope/vim-abolish'
Plug 'morhetz/gruvbox'
Plug 'RaafatTurki/hex.nvim'

vim.call('plug#end')

vim.cmd([[ 
  source ~/.vimrc 
  syntax enable
  set termguicolors
  set smartcase
  set ignorecase
  colorscheme gruvbox
  set background=light
  set noswapfile
  set undofile
  set undodir=~/.vim/undo
  set mouse=a
  set nomodeline
  set modelines=0
  set number relativenumber
  set clipboard=unnamed
  set encoding=utf-8
  set expandtab
  set tabstop=2
  set shiftwidth=0
  set splitbelow
  set splitright
  syntax on
  set wildoptions=pum
  highlight Pmenu guibg=NONE
  set foldcolumn=0
  set nocursorline
  set ttyfast
  set autowrite
  set autoread
  set history=10000 
  set noerrorbells
  set novisualbell
  set grepprg=rg
  set updatetime=50
  set selection=inclusive
  set scrolloff=5
  set matchpairs+=<:>
  highlight Comment cterm=italic
  highlight clear SignColumn
  set clipboard=unnamed,unnamedplus
  filetype plugin indent on
  set laststatus=3
  set fillchars=stlnc:⚊,vert:\│ 
  highlight VertSplit cterm=NONE gui=NONE
  highlight WinSeparator cterm=NONE gui=NONE
  set hidden
  set nobackup
  set nowritebackup
  set rtp+=/usr/local/opt/fzf
  set cmdheight=2
  set shortmess+=c
  set signcolumn=auto
  set statusline=
  set statusline=%#LineNr#%F:%l:%c:%o\ │\ %=%{coc#status()}%{get(b:,'coc_current_function','')}%=\ │\ %p%%
]])

require 'hex'.setup()
