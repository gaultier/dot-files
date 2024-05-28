vim.env.BAT_THEME='ansi'
vim.env.FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
vim.g.fzf_preview_window = {'right:50%', 'ctrl-/'}
vim.g.gitgutter_enabled = 1
vim.g.go_doc_keywordprg_enabled = 0
vim.g.indentLine_char = '┊'
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.o.autoread = true
vim.o.autowrite = true
vim.o.background = 'light'
vim.o.backup = false
vim.o.clipboard = 'unnamedplus'
vim.o.cmdheight = 2
vim.o.cursorline = false
vim.o.encoding = 'utf-8'
vim.o.errorbells = false
vim.o.expandtab = true
vim.o.fillchars = 'stlnc:⚊,vert:│'
vim.o.foldcolumn = '0'
vim.o.grepprg = 'rg'
vim.o.hidden = true
vim.o.history = 10000 
vim.o.ignorecase = true
vim.o.laststatus = 3
vim.o.matchpairs = vim.o.matchpairs .. ',<:>'
vim.o.modeline = false
vim.o.modelines = 0
vim.o.mouse = 'a'
vim.o.relativenumber = true
vim.o.number = true
vim.o.omnifunc = true
vim.o.scrolloff = 5
vim.o.selection = 'inclusive'
vim.o.shiftwidth = 0
vim.o.shortmess = 'c'
vim.o.signcolumn = 'auto'
vim.o.smartcase = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.statusline = '%#LineNr#%F:%l:%c:%o │ %=%= │ %p%%'
vim.o.swapfile = false
vim.o.tabstop = 2
vim.o.termguicolors = true
vim.o.ttyfast = true
vim.o.undodir = '/home/pg/.vim/undo'
vim.o.undofile = true
vim.o.updatetime = 50
vim.o.visualbell = false
vim.o.wildoptions = 'pum'
vim.o.writebackup = false

vim.api.nvim_command('highlight Comment cterm=italic')
vim.api.nvim_command('highlight clear SignColumn')
vim.api.nvim_command('filetype plugin indent on')
vim.api.nvim_command('highlight VertSplit cterm=NONE gui=NONE')
vim.api.nvim_command('highlight WinSeparator cterm=NONE gui=NONE')

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


vim.api.nvim_create_user_command('Rg', function(arg)
  local cmd = 'rg --column --line-number --no-heading --color=always --smart-case --hidden ' .. vim.fn.join(arg.fargs, ' ')
  vim.call('fzf#vim#grep', cmd, vim.call('fzf#vim#with_preview', {options= { '--layout=reverse', '--info=inline'}}))
end,
{
  force=true,
  range=false,
  nargs='*',
  bang=true, 
  desc='Search with rg',
})

vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'}, {
  pattern = '*.nasm',
  callback = function()
    vim.cmd('set filetype asm')
  end,
  desc = 'Treat .nasm files as .asm files',
})

vim.keymap.set({'v', 'n'}, '<leader>x', ':GitWebUiUrlCopy<CR>')
vim.api.nvim_create_user_command('GitWebUiUrlCopy', function(arg)
  local file_path = vim.fn.expand('%:p')
  local line_start = arg.line1
  local line_end = arg.line2

  local cmd_handle = io.popen('git ls-files ' .. file_path)
  local file_path_relative_to_git_root = cmd_handle:read('*a')
  cmd_handle.close()
  file_path_relative_to_git_root = string.gsub(file_path_relative_to_git_root, "%s+$", "")

  local cmd_handle = io.popen('git remote get-url origin')
  local git_origin = cmd_handle:read('*a')
  cmd_handle.close()
  git_origin = string.gsub(git_origin, "%s+$", "")

  local cmd_handle = io.popen('git rev-parse HEAD')
  local git_commit = cmd_handle:read('*a')
  cmd_handle.close()
  git_commit = string.gsub(git_commit, "%s+$", "")

  local url = ''
  if string.match(git_origin, 'github') then
    for host, user, project in string.gmatch(git_origin, 'git@([^:]+):([^/]+)/([^/]+)%.git') do
      url = 'https://' .. host .. '/' .. user .. '/' .. project .. '/blob/' .. git_commit .. '/' .. file_path_relative_to_git_root .. '#L' .. line_start .. '-L' .. line_end
      break
    end
  elseif string.match(git_origin, 'azure.com') then
    -- End is exclusive in that case hence the `+ 1`.
    line_end = line_end + 1

    for host, org, dir, project in string.gmatch(git_origin, 'git@ssh%.([^:]+):v3/([^/]+)/([^/]+)/([^\n]+)') do
      url = 'https://' .. host .. '/' .. org .. '/' .. dir .. '/_git/' .. project .. '?lineStartColumn=1&lineStyle=plain&_a=contents&version=GC' .. git_commit .. '&path=' .. file_path_relative_to_git_root .. '&line=' .. line_start .. '&lineEnd=' .. line_end
      break
    end
  else
    print('Hosting provider not supported')
  end

  vim.fn.setreg('+', url)
  os.execute('xdg-open "' .. url .. '"')
end,
{force=true, range=true, nargs=0, desc='Copy to clipboard a URL to a git webui for the current line'})

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

local PlugDir = vim.fn.stdpath('data') .. '/plugged'
local Plug = vim.fn['plug#']

vim.call('plug#begin', PlugDir)

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
Plug('https://github.com/neovim/nvim-lspconfig', {['dir'] = PlugDir .. '/lspconfig.nvim'})
Plug 'sheerun/vim-polyglot'
Plug 'fatih/vim-go'
Plug 'https://github.com/tpope/vim-fugitive'
Plug('junegunn/fzf', { 
  ['do'] = function()
	vim.call('fzf#install()')
  end
})
-- Plug('glacambre/firenvim', { 
--   ['do'] = function()
-- 	vim.call('firenvim#install(0)')
--   end
-- })
Plug 'junegunn/fzf.vim'
Plug 'https://github.com/tpope/vim-abolish'
Plug 'morhetz/gruvbox'
-- Plug 'RaafatTurki/hex.nvim'
-- Plug 'jiangmiao/auto-pairs'

vim.call('plug#end')
vim.api.nvim_command('colorscheme gruvbox')
vim.api.nvim_command('syntax enable')


function grep_current_word()
  local word = vim.fn.expand('<cword>')
  vim.api.nvim_command('Rg ' .. word)
end
vim.keymap.set('n', '<c-g>', grep_current_word)

-- require 'hex'.setup()

-- Add additional capabilities supported by nvim-cmp
local capabilities = require('cmp_nvim_lsp').default_capabilities()

local lspconfig = require('lspconfig')

lspconfig.denols.setup{}
lspconfig.clangd.setup{}
lspconfig.zls.setup{}
lspconfig.gopls.setup({
    settings = {
      gopls = {
        buildFlags = { "-tags=db_tests,dev,e2e_tests,property_tests,transfer_tests" },
        directoryFilters = {"-**/out"}
    }
  }
})
lspconfig.ols.setup({})
lspconfig.rust_analyzer.setup{}

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

-- Format on save.
vim.api.nvim_create_autocmd('BufWritePre', {
   pattern = {'*.json', '*.rs', '*.odin', '*.ts', '*.cpp', '*.c', '*.h'},
   callback = function() 
     vim.lsp.buf.format {async=false}
   end,
})

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
    -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)

    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client.server_capabilities.documentHighlightProvider then
      vim.cmd [[
        hi! LspReferenceRead cterm=bold ctermbg=235 guibg=LightYellow
        hi! LspReferenceText cterm=bold ctermbg=235 guibg=LightYellow
        hi! LspReferenceWrite cterm=bold ctermbg=235 guibg=LightYellow
      ]]
      vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
      vim.api.nvim_clear_autocmds { buffer = ev.buf, group = "lsp_document_highlight" }
      vim.api.nvim_create_autocmd("CursorHold", {
        callback = vim.lsp.buf.document_highlight,
        buffer = ev.buf,
        group = "lsp_document_highlight",
        desc = "Document Highlight",
      })
      vim.api.nvim_create_autocmd("CursorMoved", {
        callback = vim.lsp.buf.clear_references,
        buffer = ev.buf,
        group = "lsp_document_highlight",
        desc = "Clear All the References",
      })
    else
      print('does not have highlight')
    end
  end,
})

function FormatFunction()
  vim.lsp.buf.format({
    async = true,
    range = {
      ["start"] = vim.api.nvim_buf_get_mark(0, "<"),
      ["end"] = vim.api.nvim_buf_get_mark(0, ">"),
    }
  })
end
