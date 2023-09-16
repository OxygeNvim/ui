local M = {}

local fn = vim.fn
local api = vim.api

local icons = require('oxygen.ui.modules.icons')

--- @param merge_filename_and_extension boolean
--- @param bufnr? number
---
--- @return string, string
M.get_filename = function(merge_filename_and_extension, bufnr)
  local filename, extension

  if bufnr then
    local name = api.nvim_buf_get_name(bufnr)
    filename = fn.fnamemodify(fn.fnamemodify(name, ':t'), ':r')
    extension = fn.fnamemodify(name, ':e')
  else
    filename = fn.fnamemodify(fn.expand('%:t'), ':r')
    extension = fn.expand('%:e')
  end

  if filename == '' then
    filename = 'Empty'
  end

  if filename:sub(1, 1) == ' ' then
    filename = filename:sub(2)
  end

  if filename:sub(-1, -1) == ' ' then
    filename = filename:sub(1, -2)
  end

  if #filename > 16 then
    filename = table.concat({ filename:sub(1, 14), '...' })
  end

  if merge_filename_and_extension and extension ~= '' then
    filename = filename .. '.' .. extension
  end

  return filename, extension
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
