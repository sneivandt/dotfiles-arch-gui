-- Imports ---------------------------------------------------------------- {{{
import XMonad
import XMonad.Actions.CycleWS
import XMonad.Config.Desktop
import XMonad.Hooks.DynamicLog
import qualified XMonad.Hooks.EwmhDesktops as ED
import XMonad.Hooks.ManageDocks
import XMonad.Layout.Fullscreen
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
  xmonad
    $ ED.ewmhFullscreen
    $ docks
    $ desktopConfig
      { modMask            = mod4Mask
      , borderWidth        = 2
      , normalBorderColor  = "#263238"
      , focusedBorderColor = "#607d8b"
      , layoutHook         = myLayoutHook
      , manageHook         = fullscreenManageHook <+> manageDocks
      , handleEventHook    = fullscreenEventHook
      , logHook            = myLogHook wsBar
      } `additionalKeysP` myKeys
-- }}}
-- Layout ----------------------------------------------------------------- {{{
myLayoutHook = avoidStruts
             $ smartBorders
             $ mkToggle (FULL ?? EOT)
             $ mkToggle (single REFLECTX)
             $ mkToggle (single REFLECTY)
             $ mkToggle (single MIRROR)
             $ mkToggle (single NOBORDERS)
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
  -- Windows
  , ("M-<End>",     spawn "$XDG_CONFIG_HOME/lock.sh")
    -- Layout
  , ("M-f",         sendMessage $ Toggle FULL)
  , ("M-x",         sendMessage $ Toggle REFLECTX)
  , ("M-y",         sendMessage $ Toggle REFLECTY)
  , ("M-z",         sendMessage $ Toggle MIRROR)
    -- Workspaces
  , ("M-<Tab>",     moveTo Next (Not emptyWS))
  , ("M-S-<Tab>",   moveTo Prev (Not emptyWS))
    -- Programs
  , ("M-<Return>",  spawn "$XDG_CONFIG_HOME/xmonad/scripts/choose-term.sh")
  , ("M-o",         spawn "$XDG_CONFIG_HOME/xmonad/scripts/choose-browser.sh")
  , ("M-i",         spawn "$XDG_CONFIG_HOME/xmonad/scripts/choose-editor.sh")
  , ("M-S-o",       spawn ("item=$(echo 'amazon\nlichess\nteams\ntwitch\nnetflix\noutlook\nyoutube' | dmenu -i -p 'Chroium App' " ++ dmenuArgs ++ ") && $XDG_CONFIG_HOME/xmonad/scripts/choose-browser.sh $item"))
    -- Media
  , ("M-m",         spawn "$XDG_CONFIG_HOME/xmonad/scripts/mute.sh")
    -- Appearance
  , ("M-w",         spawn "$XDG_CONFIG_HOME/wallpaper/wallpaper.sh")
  ]
-- }}}
-- Xmobar ----------------------------------------------------------------- {{{
myLogHook h = dynamicLogWithPP $ wsPP { ppOutput = hPutStrLn h }
myWsBar     = "xmobar $XDG_CONFIG_HOME/xmonad/xmobar.hs"
wsPP        = xmobarPP
              { ppOrder   = \(ws:l:t:r) -> ws:l:t:r
              , ppTitle   = \t -> shorten 64 t
              , ppCurrent = \_ -> "<fn=0>\xf111</fn>"
              , ppHidden  = \_ -> "<fn=1>\xf111</fn>"
              , ppSep     = xmobarColor "#283436" "" " \xf105 "
              , ppWsSep   = " "
              }
-- }}}
