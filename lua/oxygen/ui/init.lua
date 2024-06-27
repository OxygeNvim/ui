local M = {}

M.setup = function()
  require('oxygen.ui.modules.input')
  require('oxygen.ui.modules.select')

  require('oxygen.ui.modules.statusline').setup()
end

return M
