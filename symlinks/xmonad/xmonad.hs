-- XMonad Config

import XMonad

import XMonad.Actions.CycleWS

import XMonad.Config.Desktop

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks

import XMonad.Layout.Gaps
import XMonad.Layout.Spacing

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
              { ppCurrent = xmobarColor "#d1d1d1" ""
              , ppTitle   = xmobarColor "#d1d1d1" "" . shorten 64
              , ppOrder   = \(ws:l:t:_) -> [ws,t]
              }

-- Key Bindings
myKeys =
  [ ("M-<Return>", spawn "~/.xmonad/scripts/choose-term.sh")
  , ("M-<Tab>",    toggleWS)
  , ("M-p",        spawn "dmenu_run -fn 'xft:monospace:size=9:bold:antialias=true'")
  , ("M-o",        spawn "~/.xmonad/scripts/choose-browser.sh")
  , ("M-i",        spawn "~/.xmonad/scripts/choose-editor.sh")
  , ("M-q",        kill)
  , ("M-r",        spawn "if type xmonad; then xmonad --recompile && xmonad --restart; else xmessage xmonad not in \\$PATH: \"$PATH\"; fi")
  ]

-- Layout
myLayoutHook = spacingRaw True (Border 0 4 4 4) True (Border 4 4 4 4) True $ avoidStruts (tall ||| Mirror tall)
    where tall = Tall 1 (3/100) (1/2)

