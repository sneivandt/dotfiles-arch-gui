Config {
-- Apearance -------------------------------------------------------------- {{{
      font            = "xft:Source Code Pro:pixelsize=11:antialias=true:hinting=true"
    , additionalFonts = [ "xft:Font Awesome 5 Free:pixelsize=11:antialias=true:hinting=true"
                        , "xft:Font Awesome 5 Free Solid:pixelsize=11:antialias=true:hinting=true"
                        , "xft:Font Awesome 5 Brands:pixelsize=11:antialias=true:hinting=true"
                        ]
    , bgColor         = "black"
    , fgColor         = "#d1d1d1"
    , alpha           = 150
    , position        = Top
-- }}}
-- Layout ----------------------------------------------------------------- {{{
    , sepChar  = "%"
    , alignSep = "}{"
    , template = " %StdinReader%}{%playing%  %msft%  %uname%  %volume%  %date%  %time% "
-- }}}
-- General ---------------------------------------------------------------- {{{
    , lowerOnStart     = True
    , hideOnStart      = False
    , allDesktops      = True
    , overrideRedirect = True
    , pickBroadest     = False
    , persistent       = True
-- }}}
-- Commands --------------------------------------------------------------- {{{
    , commands =
      [ Run Date "<fn=2></fn> %H:%M"                                              "time"    10
      , Run Date "<fn=2></fn> %a %b %m"                                           "date"    10
      , Run Com  "bash" ["-c", "~/.xmonad/scripts/playing.sh '<fn=3></fn>'"]      "playing" 60
      , Run Com  "bash" ["-c", "~/.xmonad/scripts/uname.sh   '<fn=3></fn>'"]      "uname"   60
      , Run Com  "bash" ["-c", "~/.xmonad/scripts/volume.sh  '<fn=2></fn>'"]      "volume"  60
      , Run Com  "bash" ["-c", "~/.xmonad/scripts/stock.py   '<fn=3></fn>' msft"] "msft"    60
      , Run StdinReader
      ]
-- }}}
}
