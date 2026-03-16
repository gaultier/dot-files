vim.env.BAT_THEME='ansi'
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
vim.o.fillchars = 'stlnc:-,vert:│'
vim.o.foldcolumn = '0'
-- vim.o.foldmethod = "indent"
-- vim.o.foldmethod = "expr"
-- vim.o.foldenable = true
-- vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.grepprg = 'rg --vimgrep'
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
-- vim.o.omnifunc = true
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
vim.keymap.set('n', '<c-p>', ':Telescope find_files<CR>')
vim.keymap.set('n', '<leader>cp', ':let @+ = expand("%:p")<CR>')
vim.keymap.set('n', '<leader>cr', ':let @+ = expand("%")<CR>')
vim.keymap.set('n', '<leader>cf', ':let @+ = expand("%:t")<CR>')
vim.keymap.set('n', '<c-k>', '<C-w>k')
vim.keymap.set('n', '<c-j>', '<C-w>j')
vim.keymap.set('n', '<c-h>', '<C-w>h')
vim.keymap.set('n', '<c-l>', '<C-w>l')
vim.keymap.set('n', '<c-g>', ':Telescope grep_string<CR>')
vim.keymap.set('n', '<leader>l', ':nohl<CR>:lclose<CR>:cclose<CR>')
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[g', function() vim.diagnostic.jump({count = -1}) end)
vim.keymap.set('n', ']g', function() vim.diagnostic.jump({count = 1}) end)



vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'}, {
  pattern = '*.nasm',
  callback = function()
    vim.cmd('set ft=asm')
  end,
  desc = 'Treat .nasm files as .asm files',
})

vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'}, {
  pattern = '*.dtrace',
  callback = function()
    vim.cmd('set ft=awk')
  end,
  desc = 'Treat .dtrace files as .awk files',
})


-- Copy the current `file:line` to the clipboard to easily set
-- a debugger breakpoint in gdb.
vim.keymap.set({ 'n'}, '<leader>m', ':FileLineCopy<CR>')
vim.api.nvim_create_user_command('FileLineCopy', function()
  local file_path = vim.fn.expand('%')
  local line = vim.fn.line('.')
  local res = file_path .. ':' .. line
  vim.fn.setreg('+', res)
end,
{force=true, range=false, nargs=0, desc='Copy to clipboard: `<file>:<line>`'})

-- Copy a git forge link to the current line or visual range, to the clipboard.
-- TODO: Add an argument to do this for the tip commit of the main branch.
vim.keymap.set({'v', 'n'}, '<leader>x', ':GitWebUiUrlCopy<CR>')
vim.api.nvim_create_user_command('GitWebUiUrlCopy', function(arg)
  local file_path_abs = vim.fn.expand('%:p')
  local file_path_rel_cmd = io.popen('git ls-files --full-name "' .. file_path_abs .. '"')
  if file_path_rel_cmd == nil then
    return
  end
  local file_path_relative_to_git_root = file_path_rel_cmd:read('*a')
  file_path_relative_to_git_root = string.gsub(file_path_relative_to_git_root, "%s+$", "")
  file_path_rel_cmd:close()

  local line_start = arg.line1
  local line_end = arg.line2

  local cmd_handle_get_url = io.popen('git remote get-url origin')
  if cmd_handle_get_url == nil then
    return
  end
  local git_origin = cmd_handle_get_url:read('*a')
  cmd_handle_get_url:close()
  git_origin = string.gsub(git_origin, "%s+$", "")

  local cmd_handle_head = io.popen('git rev-parse HEAD')
  if cmd_handle_head == nil then
    return
  end
  local git_commit = cmd_handle_head:read('*a')
  cmd_handle_head:close()
  git_commit = string.gsub(git_commit, "%s+$", "")

  local url = ''
  if string.match(git_origin, 'github') then
    if string.match(git_origin, 'git@') then
      for host, user, project in string.gmatch(git_origin, 'git@([^:]+):([^/]+)/([^/]+)%.git') do
        url = 'https://' .. host .. '/' .. user .. '/' .. project .. '/blob/' .. git_commit .. '/' .. file_path_relative_to_git_root .. '#L' .. line_start .. '-L' .. line_end
        break
      end
    elseif string.match(git_origin, 'https://') then
      url = git_origin:sub(1, #git_origin-4) .. '/blob/' .. git_commit .. '/' .. file_path_relative_to_git_root .. '#L' .. line_start .. '-L' .. line_end
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

  -- Copy to clipboard.
  vim.fn.setreg('+', url)

  -- Open URL in the default browser.
  local os_name = vim.loop.os_uname().sysname
  if os_name == 'Linux' or os_name == 'FreeBSD' or os_name == 'OpenBSD' or os_name == 'NetBSD' then
    os.execute('xdg-open "' .. url .. '"')
  elseif os_name == 'Darwin' then
    os.execute('open "' .. url .. '"')
  elseif os_name == 'Windows' then
    os.execute('start "' .. url .. '"')
  else
    print('Unknown os: ' .. os_name)
  end
end,
{force=true, range=true, nargs=0, desc='Copy to clipboard a URL to a git webui for the current line'})

-- Format a visually selected json snippet in-place with `jq`.
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

-- Undo tree.
Plug 'https://github.com/mbbill/undotree'
-- Change casing/spelling.
-- `crs`: snake_case.
-- `crm`: MixedCase.
-- `crc`: camelCase.
-- `cru`: UPPER_CASE.
-- `cr-`: dash-case.
-- `cr.`: dot.case.
-- `:Subvert/child{,ren}/adult{,s}/g`.
Plug 'https://github.com/tpope/vim-abolish'
-- Comment lines out.
-- `gc` to (un)comment a visual region.
-- `gcc` to (un)comment the current line.
-- Plug 'https://github.com/tpope/vim-commentary'
-- UNIX commands in vim. E.g. `:Rename`, `:Remove` etc.
Plug 'https://github.com/tpope/vim-eunuch'
-- Exchange 2 regions.
-- `cxiw` twice exchanges 2 words.
Plug 'https://github.com/tommcdo/vim-exchange'
-- Show lines changes via git.
Plug 'https://github.com/airblade/vim-gitgutter'
-- Lots of cool shortcuts. See `:h unimpaired.txt`.
Plug 'https://github.com/tpope/vim-unimpaired'
-- Work on pairs of quotes, brackets, parentheses, etc.
Plug 'https://github.com/tpope/vim-surround'
-- Suggestions engine.
Plug('https://github.com/hrsh7th/nvim-cmp')
-- TAB suggestions based on LSP.
Plug('https://github.com/hrsh7th/cmp-nvim-lsp')
-- Configure various LSPs.
Plug('https://github.com/neovim/nvim-lspconfig', {['dir'] = PlugDir .. '/lspconfig.nvim'})
-- Syntax highlighting for lots of languages including niche ones.
Plug 'https://github.com/sheerun/vim-polyglot'
-- Golang tools.
Plug 'https://github.com/fatih/vim-go'
-- Git commands.
-- `:Git blame`, mostly.
Plug 'https://github.com/tpope/vim-fugitive'
-- ?
Plug 'https://github.com/nvim-lua/plenary.nvim'
-- Pop-up to search and explore.
Plug('https://github.com/nvim-telescope/telescope.nvim',  { tag= '0.1.8' })
-- Faster fuzzy search using native.
Plug('https://github.com/nvim-telescope/telescope-fzf-native.nvim', { ['do']= 'make' })
Plug 'https://github.com/nvim-treesitter/nvim-treesitter'
-- Color theme.
Plug 'https://github.com/morhetz/gruvbox'

vim.call('plug#end')
vim.api.nvim_command('colorscheme gruvbox')
vim.api.nvim_command('syntax enable')


-- Configure Telescope.
require('telescope').setup({
  defaults = {
    layout_config = {width=0.999, height=0.999}
      -- other layout configuration here
    },
  pickers = {
    find_files = {
      hidden = true,
      -- Optional: if you also want to see files ignored by .gitignore
      -- no_ignore = true, 
    }
  }
})


local lspconfig = require('lspconfig')

lspconfig.lua_ls.setup {
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using
        -- (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {
          'vim',
          'require'
        },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}
lspconfig.ts_ls.setup{}
lspconfig.clangd.setup{}
-- lspconfig.zls.setup{}
lspconfig.gopls.setup({
    settings = {
      gopls = {
        buildFlags = { "-tags='sqlite'" },
        directoryFilters = {"-**/out"}
    }
  }
})

-- lspconfig.ols.setup({
--     init_options = {
--       checker_args = "-strict-style",
--   },
-- })

lspconfig.rust_analyzer.setup{
  settings = {
    ['rust-analyzer'] = {
      cargo = {
        features = "all"
      }
    }
  }
}

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  mapping = cmp.mapping.preset.insert({
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


-- Prefer `//` over `/* ... */` for commenting.
vim.api.nvim_create_autocmd('FileType', {
   pattern = {'*.odin', '*.ts', '*.tsx', '*.cpp', '*.c', '*.h', '*.d'},
   callback = function()
     vim.opt_local.commentstring = '// %s'
   end,
})

-- Format on save.
vim.api.nvim_create_autocmd('BufWritePre', {
   pattern = {'*.json', '*.rs', '*.odin', '*.ts', '*.tsx', '*.cpp', '*.c', '*.h'},
   callback = function()
     vim.lsp.buf.format {async=false}
   end,
})

-- Set up various LSP-based shortcuts e.g. rename, goto implementation, etc.
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
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>f', vim.lsp.buf.format, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)

    -- Highlight all usages of the variable under the cursor,
    -- if the LSP supports it.
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client == nil then
      do return end
    end
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

-- Search with `rg` and show preview in floating window.
-- NOTE: `:Telescope grep_string` does the same with the word under the cursor
-- or currently visually selected.
vim.api.nvim_create_user_command('Rg', function(arg)
  vim.cmd('grep '.. vim.fn.join(arg.fargs, ' '))
  vim.cmd('Telescope quickfix')
end,
{
  force=true,
  range=false,
  nargs='*',
  bang=true,
  desc='Search with rg',
})
