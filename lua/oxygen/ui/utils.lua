local M = {}

local fn = vim.fn
local api = vim.api

local icons = require('oxygen.ui.modules.icons')

--- @param bufnr? number
---
--- @return string file_name, string file_extension
M.get_file_name = function(bufnr)
  local file_name, file_extension

  if bufnr then
    local name = api.nvim_buf_get_name(bufnr)
    file_name = fn.fnamemodify(fn.fnamemodify(name, ':t'), ':r')
    file_extension = fn.fnamemodify(name, ':e')
  else
    file_name = fn.fnamemodify(fn.expand('%:t'), ':r')
    file_extension = fn.expand('%:e')
  end

  if file_name == '' then
    file_name = 'Empty'
  end

  if file_name:sub(1, 1) == ' ' then
    file_name = file_name:sub(2)
  end

  if file_name:sub(-1, -1) == ' ' then
    file_name = file_name:sub(1, -2)
  end

  if #file_name > 16 then
    file_name = table.concat({ file_name:sub(1, 14), '...' })
  end

  if file_extension ~= '' then
    file_name = file_name .. '.' .. file_extension
  end

  return file_name, file_extension
end

--- @param file_name string
--- @param file_extension string
--- @param default_hl string
---
--- @return string icon, string color
M.get_icon = function(file_name, file_extension, default_hl)
  local icon = icons.file
  local color = ''

  local ok_devicons, devicons = r('nvim-web-devicons')
  if ok_devicons then
    local ft_icon, ft_color = devicons.get_icon_color(file_name, file_extension)
    icon = (ft_icon ~= nil and ft_icon) or icon
    color = (ft_color ~= nil and ft_color) or default_hl
  end

  return icon, color
end

--- @param bufnr number
---
--- @return boolean
M.is_buffer_valid = function(bufnr)
  return api.nvim_buf_is_valid(bufnr) and api.nvim_buf_get_option(bufnr, 'buflisted')
end

--- @param bufnr number
---
--- @return boolean
M.is_modified = function(bufnr)
  return bufnr and api.nvim_buf_get_option(bufnr, 'modified') or false
end

--- @param bufnr number
---
--- @return boolean
M.is_readonly = function(bufnr)
  return bufnr and api.nvim_buf_get_option(bufnr, 'readonly') or false
end

return M
