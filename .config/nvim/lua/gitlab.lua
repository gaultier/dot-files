function exec_and_get_output_cmd(cmd)
  local f = io.popen(cmd)
  local output = f:read('*a')
  f:close()
  return output
end

function get_gitlab_project_path()
  local url = exec_and_get_output_cmd('git remote get-url origin')
  -- HACK
  return string.sub(url, 21, -6)
end

function get_git_current_branch()
  return exec_and_get_output_cmd('git rev-parse --abbrev-ref HEAD')
end

function get_current_line()
  return vim.api.nvim_win_get_cursor(0)[1]
end

function gitlab_url_at_point(line)
  local file_path = vim.fn.expand('%')
  return 'https://gitlab.ppro.com/' .. get_gitlab_project_path() .. '/-/tree/' .. get_git_current_branch() .. '/' .. file_path .. '#L' .. line
end

function open_gitlab_url_at_point()
  os.execute('open "' .. gitlab_url_at_point(get_current_line()) .. '"')
end

function copy_gitlab_url_at_point()
  vim.fn.setreg('*', gitlab_url_at_point(get_current_line()))
end

-- vim.api.nvim_add_user_command('GitlabUrlAtPointOpen', open_gitlab_url_at_point)
-- vim.api.nvim_add_user_command('GitlabUrlAtPointCopy', copy_gitlab_url_at_point)

