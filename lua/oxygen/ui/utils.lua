local M = {}

local fn = vim.fn
local api = vim.api

local icons = require('oxygen.ui.icons')

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
---
--- @return string, string|nil
M.get_devicon = function(file_name, file_extension)
  local ft_icon, ft_color = require('nvim-web-devicons').get_icon_color(file_name, file_extension)

  ft_icon = (ft_icon ~= nil and ft_icon) or icons.file

  return ft_icon, ft_color
end

return M
