Config {
-- Apearance -------------------------------------------------------------- {{{
      font            = "xft:Source Code Pro:pixelsize=11:antialias=true:hinting=true\
                        \,Font Awesome 5 Free Solid:pixelsize=11:antialias=true:hinting=true\
                        \,Noto Sans CJK CH:pixelsize=11:antialias=true:hinting=true\
                        \,Noto Sans CJK JP:pixelsize=11:antialias=true:hinting=true\
                        \,Noto Sans CJK KR:pixelsize=11:antialias=true:hinting=true"
    , additionalFonts = [ "xft:Font Awesome 5 Free:pixelsize=11:antialias=true:hinting=true"
                        , "xft:Font Awesome 5 Free Solid:pixelsize=11:antialias=true:hinting=true"
                        , "xft:Font Awesome 5 Brands:pixelsize=11:antialias=true:hinting=true"
                        ]
    , bgColor         = "#121212"
    , fgColor         = "#d0d0d0"
    , alpha           = 200
    , position        = Top
-- }}}
-- Layout ----------------------------------------------------------------- {{{
    , sepChar  = "%"
    , alignSep = "}{"
    , template = " %StdinReader%}{%playing%  %volume%  %date%  %time% "
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
      [ Run Date "<fn=2></fn> %H:%M"                                                        "time"    10
      , Run Date "<fn=2></fn> %a %b %d"                                                     "date"    10
      , Run Com  "bash" ["-c", "~/.config/xmonad/scripts/playing.sh '<fn=3></fn>'"]                "playing" 60
      , Run Com  "bash" ["-c", "~/.config/xmonad/scripts/volume.sh  '<fn=2></fn>' '<fn=2></fn>'"] "volume"  60
      , Run StdinReader
      ]
-- }}}
}
