local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local previewers = require('telescope.previewers')

local conf = require('telescope.config').values
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')

local base46 = require('oxygen.base46')
local icons = require('oxygen.ui.icons')

local theme_switcher = function()
  local bufnr = vim.api.nvim_get_current_buf()

  local previewer = previewers.new_buffer_previewer({
    define_preview = function(self)
      local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
      vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, lines)

      local ft = (vim.filetype.match({ buf = bufnr }) or 'diff'):match('%w+')
      require('telescope.previewers.utils').highlighter(self.state.bufnr, ft)
    end,
  })

  local picker = pickers.new({
    prompt_title = icons.color_palette .. ' Theme Switcher',
    previewer = previewer,
    finder = finders.new_table({
      results = base46.get_themes(),
    }),
    sorter = conf.generic_sorter(),
    attach_mappings = function(prompt_bufnr, map)
      map('i', '<ESC>', function()
        base46.change_theme(config.ui.theme, true)

        actions.close(prompt_bufnr)
      end)

      map('i', '<CR>', function()
        if action_state.get_selected_entry() then
          base46.change_theme(action_state.get_selected_entry()[1], true, true)

          actions.close(prompt_bufnr)
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
