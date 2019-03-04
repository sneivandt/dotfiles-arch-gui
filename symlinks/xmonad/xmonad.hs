-- XMonad Config

import XMonad
import XMonad.Actions.CycleWS
import XMonad.Config.Desktop
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Layout.Gaps
import XMonad.Layout.Grid
import XMonad.Layout.Spacing
import XMonad.Layout.Spiral
import XMonad.Util.EZConfig
import XMonad.Util.Run

-- Main
main = do
  wsBar <- spawnPipe myWsBar
  xmonad $ desktopConfig
    { terminal           = "urxvt"
    , modMask            = mod4Mask
    , borderWidth        = 2
    , normalBorderColor  = "#263238"
    , focusedBorderColor = "#607d8b"
    , layoutHook         = myLayoutHook
    , logHook            = myLogHook wsBar
    , handleEventHook    = handleEventHook desktopConfig <+> fullscreenEventHook
    } `additionalKeysP` myKeys

-- xmobar
myLogHook h = dynamicLogWithPP $ wsPP { ppOutput = hPutStrLn h }
myWsBar     = "xmobar ~/.xmonad/xmobar.hs"
wsPP        = xmobarPP
              { ppOrder   = \(ws:l:t:_) -> [ws,t]
              , ppTitle   = \t -> shorten 64 t
              , ppCurrent = \_ -> "●"
              , ppHidden  = \_ -> "○"
              , ppSep     = " "
              }

-- Key Bindings
myKeys =
  [ ("M-p",        spawn "dmenu_run -p Run -fn 'xft:monospace:pixelsize=11:antialias=true:hinting=true' -nb '#000000' -sb '#607d8b' -nf '#d1d1d1' -sf '#d1d1d1'")
  , ("M-S-p",      spawn "item=$(echo -e 'amazon.com/video\\ntwitch.tv/following\\nnetflix.com\\nyoutube.com' | dmenu -p 'Chroium App' -fn 'xft:monospace:pixelsize=11:antialias=true:hinting=true' -nb '#000000' -sb '#607d8b' -nf '#d1d1d1' -sf '#d1d1d1') && if [ ! -z $item ]; then chromium --app=\"https://$item\"; fi")
  , ("M-<Tab>",    moveTo Next NonEmptyWS)
  , ("M-S-<Tab>",  moveTo Prev NonEmptyWS)
  , ("M-q",        kill)
  , ("M-r",        spawn "if type xmonad; then xmonad --recompile && xmonad --restart; else xmessage xmonad not in \\$PATH: \"$PATH\"; fi")
  , ("M-<Return>", spawn "~/.xmonad/scripts/choose-term.sh")
  , ("M-o",        spawn "~/.xmonad/scripts/choose-browser.sh")
  , ("M-i",        spawn "~/.xmonad/scripts/choose-editor.sh")
  ]

-- Layout
myLayoutHook = spacingRaw False (Border 4 4 4 4) True (Border 4 4 4 4) True $
               avoidStruts $ myLayouts
    where
      tiles     = Tall nMaster delta ratio
      nMaster   = 1
      ratio     = 3/5
      delta     = 3/100
      myLayouts = tiles ||| Grid ||| Full
