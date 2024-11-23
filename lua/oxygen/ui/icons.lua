local M = {
  error = '󰅙',
  warn = '',
  hint = '󰌵',
  info = '󰋼',
  debug = '',
  close = '󰅖',
  dot = '',
  left = '',
  right = '',
  position = '',
  search = '',
  arrow_open = '',
  arrow_closed = '',
  branch = '',
  file = '󰈚',
  folder = '',
  sleep = '鈴',
  commit = '',
  tick = '',
  success = '󰄬',
  loading = '󰔟',
  empty_dot = '◌',
  empty = '',
  cog = '',
  copy = '',
  paste = '',
  cut = '',
  terminal = '',
  trash = '',
  color_palette = '󱥚',
  dap = {
    Stopped = { '󰁕 ', 'DiagnosticWarn', 'DapStoppedLine' },
    Breakpoint = ' ',
    BreakpointCondition = ' ',
    BreakpointRejected = { ' ', 'DiagnosticError' },
    LogPoint = '.>',
  },
  nvimtree = {
    glyphs = {
      default = '󰈚',
      symlink = '',
      folder = {
        default = '',
        empty = '',
        empty_open = '',
        open = '',
        symlink = '',
        symlink_open = '',
      },
    },
  },
  kind_icons = {
    Array = '󰅪',
    Boolean = '',
    BreakStatement = '󰙧',
    Call = '󰃷',
    CaseStatement = '󱃙',
    Class = '',
    Color = '󰏘',
    Constant = '󰏿',
    Constructor = '',
    ContinueStatement = '→',
    Copilot = '',
    Declaration = '󰙠',
    Delete = '󰩺',
    DoStatement = '󰑖',
    Enum = '',
    EnumMember = '',
    Event = '',
    Field = '',
    File = '󰈔',
    Folder = '󰉋',
    ForStatement = '󰑖',
    Function = '󰊕',
    Identifier = '󰀫',
    IfStatement = '󰇉',
    Interface = '',
    Keyword = '󰌋',
    List = '󰅪',
    Log = '󰦪',
    Lsp = '',
    Macro = '󰁌',
    MarkdownH1 = '󰉫',
    MarkdownH2 = '󰉬',
    MarkdownH3 = '󰉭',
    MarkdownH4 = '󰉮',
    MarkdownH5 = '󰉯',
    MarkdownH6 = '󰉰',
    Method = '󰆧',
    Module = '󰏗',
    Namespace = '󰅩',
    Null = '󰟢',
    Number = '󰎠',
    Object = '󰅩',
    Operator = '󰆕',
    Package = '󰆦',
    Property = '',
    Reference = '󰦾',
    Regex = '',
    Repeat = '󰑖',
    Scope = '󰅩',
    Snippet = '󰩫',
    Specifier = '󰦪',
    Statement = '󰅩',
    String = '󰉾',
    Struct = '',
    SwitchStatement = '󰺟',
    Text = '',
    Type = '',
    TypeParameter = '󰆩',
    Unit = '',
    Value = '󰎠',
    Variable = '󰀫',
    WhileStatement = '󰑖',
    Compound = '',
    Recovery = '',
    TranslationUnit = '',
    PackExpansion = '',
    TemplateTypeParm = '',
    TemplateTemplateParm = '',
    TemplateParamObject = '',
    Table = '',
    Tag = '',
    Supermaven = '',
    Calendar = '',
    Watch = '󰥔',
    Codeium = '',
    TabNine = '',
    BladeNav = '',
  },
  devicons = {
    default_icon = {
      icon = '󰈚',
      name = 'Default',
    },

    c = {
      icon = '',
      name = 'c',
    },

    css = {
      icon = '',
      name = 'css',
    },

    deb = {
      icon = '',
      name = 'deb',
    },

    Dockerfile = {
      icon = '',
      name = 'Dockerfile',
    },

    html = {
      icon = '',
      name = 'html',
    },

    jpeg = {
      icon = '󰉏',
      name = 'jpeg',
    },

    jpg = {
      icon = '󰉏',
      name = 'jpg',
    },

    js = {
      icon = '󰌞',
      name = 'js',
    },

    kt = {
      icon = '󱈙',
      name = 'kt',
    },

    lock = {
      icon = '󰌾',
      name = 'lock',
    },

    lua = {
      icon = '',
      name = 'lua',
    },

    mp3 = {
      icon = '󰎆',
      name = 'mp3',
    },

    mp4 = {
      icon = '',
      name = 'mp4',
    },

    out = {
      icon = '',
      name = 'out',
    },

    png = {
      icon = '󰉏',
      name = 'png',
    },

    py = {
      icon = '',
      name = 'py',
    },

    ['robots.txt'] = {
      icon = '󰚩',
      name = 'robots',
    },

    toml = {
      icon = '',
      name = 'toml',
    },

    ts = {
      icon = '󰛦',
      name = 'ts',
    },

    ttf = {
      icon = '',
      name = 'TrueTypeFont',
    },

    rb = {
      icon = '',
      name = 'rb',
    },

    rpm = {
      icon = '',
      name = 'rpm',
    },

    vue = {
      icon = '󰡄',
      name = 'vue',
    },

    woff = {
      icon = '',
      name = 'WebOpenFontFormat',
    },

    woff2 = {
      icon = '',
      name = 'WebOpenFontFormat2',
    },

    xz = {
      icon = '',
      name = 'xz',
    },

    zip = {
      icon = '',
      name = 'zip',
    },
  },
}

M.nvimtree.glyphs.folder.arrow_open = M.arrow_open
M.nvimtree.glyphs.folder.arrow_closed = M.arrow_closed

return M
