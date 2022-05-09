vim.api.nvim_set_keymap('n', '<Leader>z', '', { 
  noremap = true,
  callback = function()
    if vim.o.background == 'dark' then
      vim.api.nvim_set_option('background', 'light')
    else
      vim.api.nvim_set_option('background', 'dark')
    end
  end,
  -- Since Lua function don't have a useful string representation, you can use the "desc" option to document your mapping
  desc = 'Toggle dark/light background',
  silent = true })
