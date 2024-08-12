local M = {}

M.setup = function()
  require('oxygen.base46').load_highlight('oxygen.ui.statusline')

  vim.opt.statusline = '%!v:lua.require("oxygen.ui.statusline.components").table()'
end

return M
