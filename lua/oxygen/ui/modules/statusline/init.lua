local M = {}

M.setup = function()
  local base46 = require('oxygen.base46')
  base46.load_highlight('oxygen.ui.statusline')

  require('oxygen.ui.modules.statusline.components')

  vim.opt.statusline = '%!v:lua.statusline.table()'
end

return M
