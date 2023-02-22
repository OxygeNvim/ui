_G.ui = {
  statusline = {},
  lsp = {},
}

ui.setup = function()
  for _, module in pairs({
    'icons',
    'statusline',
    'lsp.rename',
  }) do
    require('oxygen.ui.' .. module)
  end

  ui.statusline.enable()
end

return ui
