local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local previewers = require('telescope.previewers')

local conf = require('telescope.config').values
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')

local base46 = require('oxygen.base46')
local base46_utils = require('oxygen.base46.utils')
local icons = require('oxygen.ui.modules.icons')

local theme_switcher = function()
  local bufnr = vim.api.nvim_get_current_buf()

  local previewer = previewers.new_buffer_previewer({
    define_preview = function(self, entry)
      local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
      vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, lines)

      local ft = (vim.filetype.match({ buf = bufnr }) or 'diff'):match('%w+')
      require('telescope.previewers.utils').highlighter(self.state.bufnr, ft)

      base46.change_theme(entry.value, false)
    end,
  })

  local picker = pickers.new({
    prompt_title = icons.color_palette .. ' Theme Switcher',
    previewer = previewer,
    finder = finders.new_table({
      results = base46_utils.get_themes(),
    }),
    sorter = conf.generic_sorter(),
    attach_mappings = function(prompt_bufnr, map)
      vim.schedule(function()
        vim.api.nvim_create_autocmd('TextChangedI', {
          buffer = prompt_bufnr,
          callback = function()
            if action_state.get_selected_entry() then
              base46.change_theme(action_state.get_selected_entry()[1], false)
            end
          end,
        })
      end)

      actions.select_default:replace(function()
        if action_state.get_selected_entry() then
          actions.close(prompt_bufnr)

          base46.change_theme(action_state.get_selected_entry()[1], true)
        end
      end)

      map('i', '<C-n>', function()
        actions.move_selection_next(prompt_bufnr)
        base46.change_theme(action_state.get_selected_entry()[1], false)
      end)

      map('i', '<Down>', function()
        actions.move_selection_next(prompt_bufnr)
        base46.change_theme(action_state.get_selected_entry()[1], false)
      end)

      map('i', '<C-p>', function()
        actions.move_selection_previous(prompt_bufnr)
        base46.change_theme(action_state.get_selected_entry()[1], false)
      end)

      map('i', '<Up>', function()
        actions.move_selection_previous(prompt_bufnr)
        base46.change_theme(action_state.get_selected_entry()[1], false)
      end)

      return true
    end,
  })

  picker:find()
end

return require('telescope').register_extension({
  exports = { theme_switcher = theme_switcher },
})
