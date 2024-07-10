local M = {}

M.setup = function()
  require('oxygen.ui.vim').setup()
  require('oxygen.ui.statusline').setup()
end

return M
