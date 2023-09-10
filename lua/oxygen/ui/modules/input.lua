--- @param opts table
--- @param on_submit function
vim.ui.input = function(opts, on_submit)
  local Input = require('nui.input')
  local event = require('nui.utils.autocmd').event

  vim.validate({
    on_confirm = { on_submit, 'function', false },
  })

  local text = ' ' .. opts.prompt:gsub(':', '')
  if text:sub(-1) ~= ' ' then
    text = text .. ' '
  end

  local popup_options = {
    border = {
      style = config.ui.border,
      text = {
        top = text,
        top_align = 'left',
      },
    },
    highlight = 'Normal:Normal',
    relative = 'cursor',
    position = {
      row = 2,
      col = 0,
    },
    size = {
      width = 25,
      height = 1,
    },
  }

  local input = Input(popup_options, {
    prompt = '',
    default_value = opts.default or '',
    on_submit = on_submit,
  })

  vim.api.nvim_buf_set_name(input.bufnr, text)

  input:mount()

  input:map('n', '<ESC>', input.input_props.on_close, { noremap = true, silent = true })
  input:map('n', '<C-c>', input.input_props.on_close, { noremap = true, silent = true })

  input:on(event.BufLeave, input.input_props.on_close, { once = true })
end
