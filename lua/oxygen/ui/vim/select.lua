--- @param items table
--- @param opts table
--- @param on_submit function
vim.ui.select = function(items, opts, on_submit)
  local Menu = require('nui.menu')
  local event = require('nui.utils.autocmd').event

  vim.validate({
    items = { items, 'table', false },
    on_choice = { on_submit, 'function', false },
  })

  opts.format_item = opts.format_item or function(line)
    return string.gsub(tostring(line), '\n', ' ')
  end

  local lines = {}
  for index, item in ipairs(items) do
    local text = opts.format_item(item)
    table.insert(lines, Menu.item(text, { value = item, idx = index }))
  end

  local text = ' ' .. opts.prompt:gsub(':', '')
  if text:sub(-1) ~= ' ' then
    text = text .. ' '
  end

  local popup_options = {
    relative = 'cursor',
    position = {
      row = 2,
      col = 0,
    },
    border = {
      style = config.ui.border,
      text = {
        top = text,
        top_align = 'left',
      },
    },
    win_options = {
      winhighlight = 'Normal:Normal',
    },
  }

  local menu = Menu(popup_options, {
    lines = lines,
    max_width = 80,
    min_width = 20,
    keymap = {
      focus_next = { 'j', '<Down>', '<Tab>' },
      focus_prev = { 'k', '<Up>', '<S-Tab>' },
      close = { '<ESC>', '<C-c>' },
      submit = { '<CR>', '<SPACE>' },
    },
    on_close = function()
      on_submit(nil, nil)
    end,
    on_submit = function(item)
      on_submit(item.value, item.idx)
    end,
  })

  menu:mount()

  menu:on(event.BufLeave, menu.menu_props.on_close, { once = true })
end
