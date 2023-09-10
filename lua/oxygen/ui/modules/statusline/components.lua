-- Creadits to nvchad for this statusline

local M = {}

local base46 = require('oxygen.base46')
local ui_utils = require('oxygen.ui.utils')
local icons = require('oxygen.ui.modules.icons')

local user_separator_style = config.ui.statusline.separator_style
local separator_l = icons.separator_styles[user_separator_style]['left']
local separator_r = icons.separator_styles[user_separator_style]['right']

local api = vim.api

M.modes = {
  ['n'] = { 'NORMAL', 'OxygenStatusLineNormalMode' },
  ['niI'] = { 'NORMAL i', 'OxygenStatusLineNormalMode' },
  ['niR'] = { 'NORMAL r', 'OxygenStatusLineNormalMode' },
  ['niV'] = { 'NORMAL v', 'OxygenStatusLineNormalMode' },
  ['no'] = { 'N-PENDING', 'OxygenStatusLineNormalMode' },
  ['i'] = { 'INSERT', 'OxygenStatusLineInsertMode' },
  ['ic'] = { 'INSERT competion', 'OxygenStatusLineInsertMode' },
  ['ix'] = { 'INSERT completion', 'OxygenStatusLineInsertMode' },
  ['t'] = { 'TERMINAL', 'OxygenStatusLineTerminalMode' },
  ['nt'] = { 'NTERMINAL', 'OxygenStatusLineTerminalMode' },
  ['!'] = { 'SHELL', 'OxygenStatusLineTerminalMode' },
  ['v'] = { 'VISUAL', 'OxygenStatusLineVisualMode' },
  ['V'] = { 'V-LINE', 'OxygenStatusLineVisualMode' },
  ['Vs'] = { 'V-LINE CTRL O', 'OxygenStatusLineVisualMode' },
  [''] = { 'V-BLOCK', 'OxygenStatusLineVisualMode' },
  ['R'] = { 'REPLACE', 'OxygenStatusLineReplaceMode' },
  ['Rv'] = { 'V-REPLACE', 'OxygenStatusLineReplaceMode' },
  ['s'] = { 'SELECT', 'OxygenStatusLineSelectMode' },
  ['S'] = { 'S-LINE', 'OxygenStatusLineSelectMode' },
  [''] = { 'S-BLOCK', 'OxygenStatusLineSelectMode' },
  ['c'] = { 'COMMAND', 'OxygenStatusLineCommandMode' },
  ['cv'] = { 'COMMAND', 'OxygenStatusLineCommandMode' },
  ['ce'] = { 'COMMAND', 'OxygenStatusLineCommandMode' },
  ['r'] = { 'PROMPT', 'OxygenStatusLineConfirmMode' },
  ['rm'] = { 'MORE', 'OxygenStatusLineConfirmMode' },
  ['r?'] = { 'CONFIRM', 'OxygenStatusLineConfirmMode' },
}

--- @return string
M.mode = function()
  local m = vim.api.nvim_get_mode().mode

  return table.concat({
    '%#',
    M.modes[m][2],
    '#',
    ' ',
    M.modes[m][1],
    ' ',
    '%#',
    M.modes[m][2],
    'Separator',
    '#',
    separator_r,
  })
end

--- @param filename string
--- @param extension string
---
--- @return string
M.fileicon = function(filename, extension)
  local icon, color = ui_utils.get_icon(filename, extension, 'OxygenStatusFileIcon')
  local hl = table.concat({ 'OxygenStatusFileIcon', extension or filename })

  local colors = base46.get_theme_tb('base_30')

  api.nvim_set_hl(0, hl, { fg = color, bg = colors.darker_black })

  return table.concat({ '%#', hl, '#', icon })
end

--- @param bufnr number
--- @param filename string
---
--- @return string
M.filename = function(bufnr, filename)
  return table.concat({
    '%#OxygenStatusLineFileName#',
    filename,
    ui_utils.is_readonly(bufnr) and '[RO]' or '',
    ui_utils.is_modified(bufnr) and '+' or '',
    ' ',
    '%#OxygenStatusLineSeparator#',
    separator_r,
  })
end

--- @return string
M.git = function()
  if not vim.b.gitsigns_head or vim.b.gitsigns_git_status then
    return ''
  end

  return table.concat({
    '%#OxygenStatusLineGitIcon#',
    icons.branch,
    ' ',
    vim.b.gitsigns_status_dict.head,
  })
end

--- @return string
M.lsp_diagnostics = function()
  if not #vim.diagnostic.get(0) then
    return ''
  end

  local error_count = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
  local warning_count = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
  local hint_count = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
  local info_count = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })

  local errors = (error_count and error_count > 0)
      and (table.concat({ '%#OxygenStatusLineLspError#', icons.error, ' ', error_count, ' ' }))
      or ''
  local warnings = (warning_count and warning_count > 0)
      and (table.concat({ '%#OxygenStatusLineLspWarning#', icons.warning, ' ', warning_count, ' ' }))
      or ''
  local hints = (hint_count and hint_count > 0)
      and (table.concat({ '%#OxygenStatusLineLspHint#', icons.hint, ' ', hint_count, ' ' }))
      or ''
  local info = (info_count and info_count > 0)
      and (table.concat({ '%#OxygenStatusLineLspInfo#', icons.info, ' ', info_count, ' ' }))
      or ''

  return table.concat({
    errors,
    warnings,
    hints,
    info,
  })
end

--- @return string
M.cursor_position = function()
  return table.concat({
    '%#OxygenStatusLineSeparator#',
    separator_l,
    '%#OxygenStatusLinePositionIcon#',
    ' ',
    '',
    ' ',
    '%#OxygenStatusLinePositionText#',
    '%3l:%-2v',
    ' ',
  })
end

--- @return string
M.table = function()
  local bufnr = api.nvim_get_current_buf()
  local filename, extension = ui_utils.get_filename(bufnr)

  return table.concat({
    M.mode(),
    ' ',
    M.fileicon(filename, extension),
    ' ',
    M.filename(bufnr, filename),
    ' ',
    M.lsp_diagnostics(),

    '%=',

    M.git(),
    ' ',
    M.cursor_position(),
  })
end

_G.statusline = M

return M
