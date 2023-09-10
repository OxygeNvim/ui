local M = {}

M.setup = function()
  require('oxygen.ui.modules.input')
  require('oxygen.ui.modules.select')

  local statusline = require('oxygen.ui.modules.statusline')
  statusline.setup()
end

return M
