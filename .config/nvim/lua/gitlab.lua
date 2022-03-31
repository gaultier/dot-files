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
  return string.sub(exec_and_get_output_cmd('git rev-parse --abbrev-ref HEAD'), 0, -2) -- Trim newline
end

function get_current_line()
  return vim.api.nvim_win_get_cursor(0)[1]
end

function get_visual_range_lines()
    local start_y = vim.api.nvim_buf_get_mark(0, '<')[1]
    local end_y = vim.api.nvim_buf_get_mark(0, '>')[1]
    return start_y, end_y
end

function gitlab_url_at_point(start_y, end_y)
  local file_path = vim.fn.expand('%')
  local url = 'https://gitlab.ppro.com/' .. get_gitlab_project_path() .. '/-/tree/' .. get_git_current_branch() .. '/' .. file_path .. '#L' .. start_y
  if end_y then
      url = url .. '-' .. end_y
  end

  return url
end

function open_gitlab_url_at_point()
  os.execute('open "' .. gitlab_url_at_point(get_current_line()) .. '"')
end

function copy_gitlab_url_at_point()
  vim.fn.setreg('*', gitlab_url_at_point(get_current_line()))
end

function copy_gitlab_url_visual_range()
  local start_y, end_y = get_visual_range_lines()
  vim.fn.setreg('*', gitlab_url_at_point(start_y, end_y))
end

function open_gitlab_url_visual_range()
  local start_y, end_y = get_visual_range_lines()
  os.execute('open "' .. gitlab_url_at_point(start_y, end_y) .. '"')
end

-- vim.api.nvim_add_user_command('GitlabUrlAtPointOpen', open_gitlab_url_at_point)
-- vim.api.nvim_add_user_command('GitlabUrlAtPointCopy', copy_gitlab_url_at_point)

