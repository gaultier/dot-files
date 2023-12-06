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
vim.keymap.set('n', '<leader>l', ':nohl<CR>:lclose<CR>:cclose<CR>')
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[g', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']g', vim.diagnostic.goto_next)


vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'}, {
  pattern = '*.nasm',
  callback = function()
    vim.cmd('set filetype asm')
  end,
  desc = 'Treat .nasm files as .asm files',
})

function print_err_on_stderr(data, cmd, line_start, line_end)
  if next(data) == nil then
    return
  end

  local err = table.concat(data, ' ')
  vim.fn.setqflist({{lnum=line_start, end_lnum=line_end, type='E', text= cmd .. ': ' .. err}}, 'r')
  vim.cmd [[ :cc ]]
end

vim.keymap.set({'v', 'n'}, '<leader>x', ':GitWebUiUrlCopy<CR>')
vim.api.nvim_create_user_command('GitWebUiUrlCopy', function(arg)
  local file_path = vim.fn.expand('%:p')
  local line_start = arg.line1
  local line_end = arg.line2
  if (line_end == line_start) then line_end = line_end + 1 end

  vim.fn.jobstart({'ado-link', file_path, line_start, line_end}, {
      stderr_buffered = true,
      on_stderr = function(_chanid, data) 
        local cmd = vim.fn.printf('"ado-link %s %d %d"', file_path, line_start, line_end)
        print_err_on_stderr(data, cmd, line_start, line_end)
      end
    })
end, 
{force=true, range=true, nargs=0, bang=true, desc='Copy to clipboard a URL to a git webui for the current line'})

vim.api.nvim_create_user_command('JqFmt', function(arg)
  -- Move from 1-index to 0-index.
  local line_start = arg.line1 - 1
  local line_end = arg.line2
  local input = table.concat(vim.api.nvim_buf_get_lines(0, line_start, line_end, true), '\n')

  local output = vim.fn.system('jq -M', input)
  if vim.v.shell_error == 0 then
    local new_lines = vim.fn.split(output, '\n')
    vim.api.nvim_buf_set_lines(0, line_start, line_end, true, new_lines)
  else
    vim.fn.setqflist({{lnum=line_start, end_lnum=line_end, type='E', text = 'Failed to format JSON'}}, 'r')
    vim.cmd [[ :cc ]]
  end
   
end, 
{force=true, range=true, nargs=0, bang=true, desc='Format JSON snippet'})
vim.keymap.set({'v', 'n'}, '<leader>j', ':JqFmt<CR>')

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
Plug('https://github.com/hrsh7th/nvim-cmp')
Plug('https://github.com/hrsh7th/cmp-nvim-lsp')
Plug('https://github.com/neovim/nvim-lspconfig', {['dir'] = '~/.vim/plugged/lspconfig.nvim'})
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
  set statusline=%#LineNr#%F:%l:%c:%o\ │\ %=%=\ │\ %p%%
]])

function grep_current_word()
  local word = vim.fn.expand('<cword>')
  vim.api.nvim_command('Rg -w ' .. word)
end
vim.keymap.set('n', '<c-g>', grep_current_word)

require 'hex'.setup()

-- Add additional capabilities supported by nvim-cmp
local capabilities = require('cmp_nvim_lsp').default_capabilities()

local lspconfig = require('lspconfig')

local servers = { 'clangd', 'rust_analyzer', 'gopls' }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    -- on_attach = my_custom_on_attach,
    capabilities = capabilities,
  }
end

lspconfig.clangd.setup{}
lspconfig.gopls.setup{}

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
  }),
}

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})
