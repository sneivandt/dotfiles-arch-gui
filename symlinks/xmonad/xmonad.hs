-- Imports ---------------------------------------------------------------- {{{
import XMonad
import XMonad.Actions.CycleWS
import XMonad.Config.Desktop
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Layout.Fullscreen
import XMonad.Layout.Gaps
import XMonad.Layout.Grid
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances
import XMonad.Layout.NoBorders
import XMonad.Operations
import XMonad.Layout.Spacing
import XMonad.Util.EZConfig
import XMonad.Util.Run
import qualified XMonad.Hooks.EwmhDesktops as Ewmh
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
    , handleEventHook    = fullscreenEventHook <+> docksEventHook <+> Ewmh.fullscreenEventHook
    , logHook            = myLogHook wsBar
    } `additionalKeysP` myKeys
-- }}}
-- Layout ----------------------------------------------------------------- {{{
myLayoutHook = avoidStruts
             $ smartBorders
             $ gaps [(U,4),(D,4),(L,4),(R,4)]
             $ spacing 4
             $ mkToggle (FULL ?? EOT) (Tall 1 (1/100) (toRational (2/(1 + sqrt 5))) ||| Grid ||| noBorders Full)
-- }}}
-- Key Bindings ----------------------------------------------------------- {{{
dmenuArgs = "-fn 'xft:monospace:pixelsize=11:antialias=true:hinting=true' -nb '#000000' -sb '#607d8b' -nf '#d1d1d1' -sf '#d1d1d1'"
myKeys =
  [
    -- Launcher
    ("M-p",         spawn ("item=$(ls /usr/share/applications | awk -F '.desktop' '{print $1}' | dmenu -p Run " ++ dmenuArgs ++ ") && gtk-launch $item.desktop"))
    -- Xmonad
  , ("M-r",         spawn "if type xmonad; then xmonad --recompile && xmonad --restart; else xmessage xmonad not in \\$PATH: \"$PATH\"; fi")
    -- Windows
  , ("M-q",         kill)
  , ("M-f",         sendMessage $ Toggle FULL)
    -- Workspaces
  , ("M-<Tab>",     moveTo Next NonEmptyWS)
  , ("M-S-<Tab>",   moveTo Prev NonEmptyWS)
    -- Programs
  , ("M-<Return>",  spawn "~/.xmonad/scripts/choose-term.sh")
  , ("M-o",         spawn "~/.xmonad/scripts/choose-browser.sh")
  , ("M-i",         spawn "~/.xmonad/scripts/choose-editor.sh")
  , ("M-S-o",       spawn ("item=$(echo -e 'amazon.com/video\\ntwitch.tv/following/live\\nnetflix.com\\nyoutube.com' | dmenu -p 'Chroium App' " ++ dmenuArgs ++ ") && ~/.xmonad/scripts/choose-browser.sh $item"))
  ]
-- }}}
-- Xmobar ----------------------------------------------------------------- {{{
myLogHook h = dynamicLogWithPP $ wsPP { ppOutput = hPutStrLn h }
myWsBar     = "xmobar ~/.xmonad/xmobar.hs"
wsPP        = xmobarPP
              { ppOrder   = \(ws:l:t:_) -> [ws,t]
              , ppTitle   = \t -> shorten 64 t
              , ppCurrent = xmobarColor "#d1d1d1" ""
              , ppHidden  = xmobarColor "#606060" ""
              , ppSep     = " "
              }
-- }}}
