-- vim: ft=lua tw=80

stds.nvim = {
  globals = {
    'vim',
    'config',
    'utils',
    'base46',
    'ui',
    'r',
  },
  read_globals = {
    'os',
    'vim',
  },
}

std = 'lua51+nvim'

self = false

cache = true

ignore = {
  '600',
}
