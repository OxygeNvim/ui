local M = {}

M.setup = function()
  local base46 = require('oxygen.base46')
  base46.load_highlight('oxygen.ui.statusline')

  vim.opt.statusline = '%!v:lua.require("oxygen.ui.statusline.components").table()'
end

return M
