import System.IO
import System.Exit
import XMonad 
import XMonad.Hooks.SetWMName
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.DynamicLog
import XMonad.Layout.NoBorders
import XMonad.Layout.Spacing (smartSpacing)
import XMonad.Layout.Spiral
import XMonad.Layout.Tabbed
import XMonad.Layout.ThreeColumns
import XMonad.Layout.ResizableTile
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run (spawnPipe)
import XMonad.Actions.FloatKeys (keysMoveWindow,
                                 keysResizeWindow)
import Graphics.X11.ExtraTypes.XF86
import XMonad.Actions.CycleWindows
import qualified XMonad.StackSet as W
import qualified Data.Map        as M

--colors
bgColor = "#002b36"
fgColor = "#eee8d5"
inactiveWinColor = "#2aa198"
activeWinColor = "#d33682"
urgentWinColor = "#dc322f"
miscColor = inactiveWinColor

myBorderWidth = 2
myTerminal = "st"
myFocusFollowsMouse = True
myNormalBorderColor = bgColor
myModMask = mod4Mask
myFocusedBorderColor = fgColor
myManageHook = composeAll
    [ className =? "Discord" --> doFloat 
    , className =? "Anki"    --> doFloat
    ]

tabConfig = def {
    activeTextColor = bgColor,
    activeColor = fgColor,
    inactiveTextColor = fgColor,
    inactiveColor = bgColor
}

myXmobarrc = "~/.xmonad/lib/xmobar.hs"

myWorkspaces = clickable $ ["\xf269", "\xf120", "\xf121", "\xf392", "\xf008", "\xf07b", "\xf11b", "\xf086", "\xf074" ]
    where clickable l = ["<action=`xdotool key super+" ++ show (n) ++ "`>" ++ ws ++ "</action>" | (i,ws) <- zip [1..9] l, let n = i ]

playerctl = "playerctl -p 'playerctld,%any'"

myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $
  [ ((modMask, xK_Return),
     spawn $ XMonad.terminal conf)

  , ((modMask, xK_d),
     spawn "dmenu_run -l 20")

  , ((modMask, xK_s),
     spawn "dmenu_websearch")
  
  , ((shiftMask, xK_Print),
     spawn "flameshot gui")

  , ((0, xK_Print),
     spawn "flameshot full -p /home/natto/Pictures")

  , ((mod1Mask, xK_Print),
     spawn "flameshot gui -d 10000")

  , ((modMask, xK_p),
     spawn (playerctl ++ " play-pause"))

  , ((0, xF86XK_AudioPlay),
     spawn (playerctl ++ " play-pause"))

  , ((modMask, xF86XK_AudioNext),
     spawn (playerctl ++ " next"))

  , ((modMask, xF86XK_AudioPrev),
     spawn (playerctl ++ " previous"))

  , ((0, xF86XK_AudioPrev),
     spawn (playerctl ++ " position 5-"))

  , ((0, xF86XK_AudioNext),
     spawn (playerctl ++ " position 5+"))

  , ((0, xF86XK_AudioRaiseVolume),
     spawn "pamixer --allow-boost -ui 5")

  , ((0, xF86XK_AudioLowerVolume),
     spawn "pamixer --allow-boost -ud 5")

  , ((0, xF86XK_AudioMute),
     spawn "pamixer -t")

  , ((modMask .|. shiftMask, xK_q), kill)

  , ((mod1Mask, xK_Tab), 
     cycleRecentWindows [xK_Alt_L] xK_Tab xK_q)

  , ((0, xF86XK_MonBrightnessUp),
     spawn "light -A 5")

  , ((0, xF86XK_MonBrightnessDown),
     spawn "light -U 5")

  , ((modMask .|. shiftMask, xK_F1),
     spawn "setxkbmap us colemak_dh")

  , ((modMask .|. shiftMask, xK_F2),
     spawn "setxkbmap us basic")

  , ((modMask .|. shiftMask, xK_F3),
     spawn "setxkbmap in deva")

  , ((modMask .|. shiftMask, xK_F4),
     spawn "setxkbmap in guru")

  , ((modMask .|. shiftMask, xK_F5),
     spawn "setxkbmap colemak dhz")

  , ((modMask, xK_space),
     sendMessage NextLayout)

  , ((modMask, xK_f),
     toggleFullscreen)

  , ((modMask .|. shiftMask, xK_space),
     setLayout $ XMonad.layoutHook conf)

  , ((modMask, xK_r),
     refresh)

  , ((modMask, xK_n),
     windows W.focusDown)

  , ((modMask, xK_e), windows W.focusUp  )

  , ((modMask .|. shiftMask, xK_h),
     windows W.focusMaster  )

  , ((modMask .|. shiftMask, xK_Return),
     windows W.swapMaster)

  , ((modMask .|. shiftMask, xK_n),
     windows W.swapDown  )

  , ((modMask .|. shiftMask, xK_e),
     windows W.swapUp    )

  , ((mod1Mask, xK_m),
     sendMessage Expand)

  , ((mod1Mask, xK_i),
     sendMessage Shrink)

  , ((mod1Mask, xK_n),
     sendMessage MirrorExpand)

  , ((mod1Mask, xK_e),
     sendMessage MirrorShrink)

  , ((modMask .|. mod1Mask .|. shiftMask, xK_m),
     withFocused (keysMoveWindow (-30, 0)))

  , ((modMask .|. mod1Mask .|. shiftMask, xK_i),
     withFocused (keysMoveWindow (30, 0)))

  , ((modMask .|. mod1Mask .|. shiftMask, xK_n),
     withFocused (keysMoveWindow (0, 30)))

  , ((modMask .|. mod1Mask .|. shiftMask, xK_e),
     withFocused (keysMoveWindow (0, -30)))

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


myLayoutHook = smartSpacing 8 $ smartBorders $ avoidStruts (
    ResizableTall 1 (3/100) (3/5) [] |||
    spiral (6/7) |||
    tabbed shrinkText tabConfig |||
    ThreeCol 1 (3/100) (1/2) |||
    Tall 1 (3/100) (1/2) |||
    Mirror (Tall 1 (3/100) (1/2)) |||
    Full)

-- {{{source: https://github.com/liskin/dotfiles/commit/659af2ec68c26044f9e6ddf11655856613285685#diff-f3bd9f70ef878f30362ff11bbea7fd1d0d6abde1b4befa44b18cce5a27456204R190
toggleFullscreen = 
    withWindowSet $ \ws ->
    withFocused $ \w -> do
        let fullRect = W.RationalRect 0 0 1 1
        let isFullFloat = w `M.lookup` W.floating ws == Just fullRect
        windows $ if isFullFloat then W.sink w else W.float w fullRect
--}}}

main = do xmproc <- spawnPipe ("xmobar " ++ myXmobarrc)
          xmonad $ docks $ ewmh def
              { borderWidth        = myBorderWidth
              , manageHook         = manageDocks <+> myManageHook 
              , handleEventHook    = handleEventHook def <+> fullscreenEventHook
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
                  , ppCurrent = xmobarColor activeWinColor "" . wrap "(" ")"
                  , ppVisible = xmobarColor activeWinColor ""
                  , ppHidden = xmobarColor inactiveWinColor ""
                  , ppTitle = xmobarColor fgColor "" . shorten 40
                  , ppLayout = const ""
                  , ppUrgent = xmobarColor urgentWinColor "" . wrap "!" ""
                  , ppSep = "<fc=" ++ miscColor ++ "> ║ </fc>"
                  }
              }
