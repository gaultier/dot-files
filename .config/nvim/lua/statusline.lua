local o = vim.o
o.statusline = ""

local timer = vim.loop.new_timer()
timer:start(0, 1000,  vim_schedule_wrap(function()
  local time = os.time()
  local utc_date = os.date('!%Y-%m-%d %H:%M:%SZ', time)
  local local_date = os.date('%Y-%m-%d %H:%M:%S CEST', time)
  o.statusline = o.statusline .. '%#LineNr#'
  o.statusline = o.statusline .. '%f'
  o.statusline = o.statusline .. '%='
  o.statusline = o.statusline .. utc_date
  o.statusline = o.statusline .. ' | '
  o.statusline = o.statusline .. local_date
  o.statusline = o.statusline .. ' %p%%'
  -- vim.api.nvim_command('echomsg "' .. date .. '"')
end))

