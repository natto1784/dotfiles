import System.IO
import System.Exit
import XMonad 
import XMonad.Config.Desktop
import XMonad.Layout.Fullscreen
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.DynamicLog
import XMonad.Layout.NoBorders
import XMonad.Layout.Spacing (smartSpacing)
import XMonad.Layout.Spiral
import XMonad.Layout.Tabbed
import XMonad.Layout.ThreeColumns
import XMonad.Layout.ResizableTile
import XMonad.Layout.ToggleLayouts (ToggleLayout(..), toggleLayouts)
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run (spawnPipe)
import qualified XMonad.StackSet as W
import qualified Data.Map        as M

myBorderWidth = 2
myTerminal = "/usr/bin/env st"
myFocusFollowsMouse = True
myNormalBorderColor = "#1d2021"
myModMask = mod4Mask
myFocusedBorderColor = "#d5c4a1"
myManageHook = composeAll
    [ className =? "mpv" --> doFloat
    , className =? "Discord" --> doFloat ]

myWorkspaces = clickable $ ["I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX" ]
    where clickable l = ["<action=`xdotool key super+" ++ show (n) ++ "`>" ++ ws ++ "</action>" | (i,ws) <- zip [1..9] l, let n = i ]

myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $
  [ ((modMask, xK_Return),
     spawn $ XMonad.terminal conf)

  , ((modMask, xK_d),
     spawn "/usr/bin/env dmenu_run -l 20")

  , ((shiftMask, xK_Print),
     spawn "flameshot gui -p /home/natto/Pictures")

  , ((0, xK_Print),
     spawn "flameshot full -p /home/natto/Pictures")

  , ((mod1Mask, xK_Print),
     spawn "flameshot full -p /home/natto/Pictures -d 10000")

  , ((modMask, xK_p),
     spawn "mpc toggle")

  , ((modMask, xK_h),
     spawn "mpc next")

  , ((modMask, xK_k),
     spawn "mpc prev")

  , ((modMask .|. shiftMask, xK_a),
     spawn "mpc seek -00:00:05")

  , ((modMask .|. shiftMask, xK_s),
     spawn "mpc seek +00:00:05")

  , ((modMask .|. shiftMask, xK_period),
     spawn "pamixer --allow-boost -i 5")

  , ((modMask .|. shiftMask, xK_comma),
     spawn "pamixer -d 5")

  , ((modMask .|. shiftMask, xK_q),
     kill)

  , ((modMask, xK_space),
     sendMessage NextLayout)

  , ((modMask, xK_f),
     sendMessage (Toggle "Full"))

  , ((modMask .|. shiftMask, xK_space),
     setLayout $ XMonad.layoutHook conf)

  , ((modMask, xK_r),
     refresh)

  , ((modMask, xK_n),
     windows W.focusDown)

  , ((modMask, xK_e), windows W.focusUp  )

  , ((modMask .|. shiftMask, xK_m),
     windows W.focusMaster  )

  , ((modMask .|. shiftMask, xK_Return),
     windows W.swapMaster)

  , ((modMask .|. shiftMask, xK_n),
     windows W.swapDown  )

  , ((modMask .|. shiftMask, xK_e),
     windows W.swapUp    )

  , ((mod1Mask, xK_m),
     sendMessage Shrink)

  , ((mod1Mask, xK_i),
     sendMessage Expand)

  , ((mod1Mask, xK_n),
     sendMessage MirrorShrink)

  , ((mod1Mask, xK_e),
     sendMessage MirrorExpand)

  , ((modMask, xK_t),
     withFocused $ windows . W.sink)

  , ((modMask, xK_comma),
     sendMessage (IncMasterN 1))

  , ((modMask, xK_period),
     sendMessage (IncMasterN (-1)))

  , ((modMask .|.  mod1Mask, xK_f),
     io (exitWith ExitSuccess))

  , ((modMask .|. mod1Mask, xK_r),
     restart "xmonad" True)
  ] 
  ++
  [((m .|. modMask, k), windows $ f i)
    | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
    , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]

myLayoutHook = toggleLayouts (noBorders Full) ( smartSpacing 8 $ smartBorders $ avoidStruts (
    spiral (1/1) |||
    tabbed shrinkText tabConfig |||
    ThreeCol 1 (3/100) (1/2) |||
    Tall 1 (3/100) (1/2) |||
    Mirror (Tall 1 (3/100) (1/2)) |||
    Full))

tabConfig = defaultTheme {
    activeTextColor = "#1d2021",
    activeColor = "#d5c4a1",
    inactiveTextColor = "#d5c4a1",
    inactiveColor = "#1d2021"
}

myXmobarrc = "~/.xmonad/lib/xmobar.hs"

main = do xmproc <- spawnPipe ("xmobar " ++ myXmobarrc)
          xmonad $ ewmh desktopConfig
              { borderWidth        = myBorderWidth
              , manageHook         = manageDocks <+> myManageHook
              , terminal           = myTerminal
              , focusFollowsMouse  = myFocusFollowsMouse
              , normalBorderColor  = myNormalBorderColor
              , layoutHook         = myLayoutHook 
              , modMask            = myModMask
              , keys               = myKeys
              , focusedBorderColor = myFocusedBorderColor
              , workspaces         = myWorkspaces
              , logHook            = dynamicLogWithPP xmobarPP
                  { ppOutput = hPutStrLn xmproc
                  , ppCurrent = xmobarColor "#b8bb26" "" . wrap "[" "]"
                  , ppVisible = xmobarColor "#b8bb26" ""
                  , ppHidden = xmobarColor "#d3869b" ""
                  , ppTitle = xmobarColor "#ebdbb2" "" . shorten 60
                  , ppLayout = const ""
                  , ppUrgent = xmobarColor "#fabd2f" "" . wrap "!" ""
                  , ppSep = "<fc=#83a598> ║ </fc>"
                  }
              }
