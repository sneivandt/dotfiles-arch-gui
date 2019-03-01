Config {

  -- appearance
      font     = "xft:monospace:size=9:bold:antialias=true"
    , bgColor  = "black"
    , fgColor  = "#d1d1d1"
    , position = Top

  -- layout
    , sepChar  = "%"
    , alignSep = "}{"
    , template = " %StdinReader%}{%msft%  %date% "

  -- general
    , lowerOnStart     = True
    , hideOnStart      = False
    , allDesktops      = True
    , overrideRedirect = True
    , pickBroadest     = False
    , persistent       = True

  -- commands
    , commands =
      [ Run Date "<fc=#ABABAB>%F %T</fc>" "date" 10
      , Run Com "bash" ["-c", "~/.xmonad/scripts/stock.py msft MSFT"] "msft" 60
      , Run StdinReader
      ]
}
