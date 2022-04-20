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

function get_path_from_git_root()
  return string.sub(exec_and_get_output_cmd('git rev-parse --show-prefix'), 0, -2) -- Trim newline
end

function gitlab_url_at_point(start_y, end_y, with_line_number)
  local path_from_git_root = get_path_from_git_root()
  local file_path = vim.fn.expand('%')
  local url = 'https://gitlab.ppro.com/' .. get_gitlab_project_path() .. '/-/tree/' .. get_git_current_branch() .. '/' .. path_from_git_root .. file_path
  if with_line_number == "true" then
    url = url .. '#L' .. start_y
    if end_y then
        url = url .. '-' .. end_y
    end
  end

  return url
end

function copy_gitlab_url(cmd)
  local reg = cmd.reg
  if cmd.reg == '' then 
    reg = '*' 
  end
  vim.fn.setreg(reg, gitlab_url_at_point(cmd.line1, cmd.line2, cmd.fargs[1]))
end

function open_gitlab_url(cmd)
  os.execute('open "' .. gitlab_url_at_point(cmd.line1, cmd.line2, cmd.fargs[1]) .. '"')
end

vim.api.nvim_create_user_command('GitlabUrlCopy', copy_gitlab_url, {range=true, nargs=1})
vim.api.nvim_create_user_command('GitlabUrlOpen', open_gitlab_url, {range=true, nargs=1})
