-- Imports ---------------------------------------------------------------- {{{
import XMonad
import XMonad.Actions.CycleWS
import XMonad.Config.Desktop
import XMonad.Hooks.DynamicLog
import qualified XMonad.Hooks.EwmhDesktops as ED
import XMonad.Hooks.ManageDocks
import XMonad.Layout.Fullscreen
import XMonad.Layout.Gaps
import XMonad.Layout.Grid
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances
import XMonad.Layout.Named
import XMonad.Layout.NoBorders
import XMonad.Layout.Reflect
import XMonad.Operations
import XMonad.Layout.Spacing
import XMonad.Util.EZConfig
import XMonad.Util.Run
-- }}}
-- Main ------------------------------------------------------------------- {{{
main = do
  wsBar <- spawnPipe myWsBar
  xmonad $ desktopConfig
    { modMask            = mod4Mask
    , borderWidth        = 2
    , normalBorderColor  = "#263238"
    , focusedBorderColor = "#607d8b"
    , layoutHook         = myLayoutHook
    , manageHook         = fullscreenManageHook <+> manageDocks
    , handleEventHook    = fullscreenEventHook <+> docksEventHook <+> ED.fullscreenEventHook
    , logHook            = myLogHook wsBar
    } `additionalKeysP` myKeys
-- }}}
-- Layout ----------------------------------------------------------------- {{{
myLayoutHook = avoidStruts
             $ smartBorders
             $ gaps [(U,4),(D,4),(L,4),(R,4)]
             $ mkToggle (FULL ?? EOT)
             $ mkToggle (single REFLECTX)
             $ mkToggle (single REFLECTY)
             $ mkToggle (single MIRROR)
             $ lMas ||| lGrd ||| lTal
               where
                 gap  = 4
                 spc  = spacingRaw True (Border gap gap gap gap) True (Border gap gap gap gap) True
                 inc  = 1/100
                 asp  = 16/9
                 grto = toRational $ 2/(1 + sqrt 5)
                 lMas = named "Master" $ spc $ Tall 1 inc grto
                 lGrd = named "Grid"   $ spc $ GridRatio asp
                 lTal = named "Tall"   $ spc $ Mirror $ Tall 0 inc grto
-- }}}
-- Key Bindings ----------------------------------------------------------- {{{
dmenuArgs = "-fn 'xft:Source Code Pro:pixelsize=14:antialias=true:hinting=true' -nb '#121212' -sb '#3465a4' -nf '#d0d0d0' -sf '#d0d0d0'"
myKeys =
  [
    -- Launcher
    ("M-p",         spawn ("item=$(ls /usr/share/applications | awk -F '.desktop' '{print $1}' | dmenu -i -p Run " ++ dmenuArgs ++ ") && gtk-launch $item.desktop"))
    -- Xmonad
  , ("M-r",         spawn "if type xmonad; then xmonad --recompile && xmonad --restart; else xmessage xmonad not in \\$PATH: \"$PATH\"; fi")
    -- Windows
  , ("M-q",         kill)
    -- Layout
  , ("M-f",         sendMessage $ Toggle FULL)
  , ("M-x",         sendMessage $ Toggle REFLECTX)
  , ("M-y",         sendMessage $ Toggle REFLECTY)
  , ("M-m",         sendMessage $ Toggle MIRROR)
    -- Workspaces
  , ("M-<Tab>",     moveTo Next NonEmptyWS)
  , ("M-S-<Tab>",   moveTo Prev NonEmptyWS)
    -- Programs
  , ("M-<Return>",  spawn "~/.xmonad/scripts/choose-term.sh")
  , ("M-o",         spawn "~/.xmonad/scripts/choose-browser.sh")
  , ("M-i",         spawn "~/.xmonad/scripts/choose-editor.sh")
  , ("M-S-o",       spawn ("item=$(echo 'amazon\nteams\ntwitch\nnetflix\noutlook\nyoutube' | dmenu -i -p 'Chroium App' " ++ dmenuArgs ++ ") && ~/.xmonad/scripts/choose-browser.sh $item"))
    -- Appearance
  , ("M-w",         spawn "~/.xmonad/scripts/wallpaper.sh")
  ]
-- }}}
-- Xmobar ----------------------------------------------------------------- {{{
myLogHook h = dynamicLogWithPP $ wsPP { ppOutput = hPutStrLn h }
myWsBar     = "xmobar ~/.xmonad/xmobar.hs"
wsPP        = xmobarPP
              { ppOrder   = \(ws:l:t:r) -> ws:l:t:r
              , ppTitle   = \t -> shorten 64 t
              , ppCurrent = \_ -> "<fn=0>\xf111</fn>"
              , ppHidden  = \_ -> "<fn=1>\xf111</fn>"
              , ppSep     = xmobarColor "#283436" "" " \xf105 "
              , ppWsSep   = " "
              }
-- }}}
