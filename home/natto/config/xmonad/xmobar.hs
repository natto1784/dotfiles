import Xmobar

bg, fg, grey, red, green, yellow, blue, magenta, cyan, white, sep :: String
sep = "<fc=" ++ cyan ++ ">║</fc>"
bg = "#002b36"
fg = "#839496"
grey = "#073642"
red = "#dc322f"
green = "#859900"
yellow = "#b58900"
blue = "#268bd2"
magenta = "#d33682"
cyan = "#2aa198"
white = "#eee8d5"

config :: Config
config =
  defaultConfig
    {
      font = "xft:Fira Mono:style=Regular:antialias=true:pixelsize,Font Awesome 6 Brands:pixelsize=16,Font Awesome 6 Free:pixelsize=16:style=Solid,Lohit Devanagari:style=Regular:pixelsize=16,Lohit Gurmukhi:style=Regular:pixelsize=16,Noto Sans CJK JP:style=Regular:pixelsize=16,Noto Sans CJK KR:style=Regular:pixelsize=16,Noto Sans CJK SC:style=Regular:pixelsize=16",
      additionalFonts =
        [ "xft:Font Awesome 6 Free:pixelsize=15:style=Solid",
          "xft:Font Awesome 6 Brands:pixelsize=15"
        ],
      position = Static { xpos = 0, ypos = 0, height = 23, width = 1920 },
      bgColor = bg,
      fgColor = fg,
      lowerOnStart = False,
      overrideRedirect = False,
      allDesktops = True,
      persistent = True,
      commands =
        [ Run $ MultiCpu ["-t", "<fn=1>\xf2db</fn> <total>%", "-L", "20", "-H", "80", "-h", magenta, "-l", green, "-n", yellow] 10,
          Run $ Memory ["-t", "<fn=1>\xf538</fn> <usedratio>%", "-H", "10240", "-L", "6144", "-h", magenta, "-l", green, "-n", yellow] 20,
          Run $ BatteryP ["BAT1", "BAT0", "BAT2"] ["-t", "<acstatus>", "-L", "10", "-H", "80", "-l", magenta, "-h", green, "-n", yellow, "--", "-O", "Charging", "-o", "<left>%", "-a", "notify-send -u critical 'Battery running out!'", "-A", "5", "--lows", "<fn=1>\xf243</fn> ", "--mediums", "<fn=1>\xf242</fn> ", "--highs", "<fn=1>\xf240</fn> "] 300,
          Run $ DynNetwork ["-t", "<fn=1>\xf1eb</fn> <fc=" ++ magenta ++ "><rx>/<tx></fc>"] 10,
          Run $ Date "<fn=1>\xf073</fn> %-d/%-m/%-y/%w" "date" 10000,
          Run $ Date "%H:%M:%S" "time" 10,
          Run $ MPD ["-t", "<statei><title><fn=" ++ magenta ++ "> \xf001</fn>", "--", "-P", ">> ", "-Z", "|| ", "-S", "Stopped", "-h", "127.0.0.1", "-p", "6600"] 10,
          Run $ Com "~/.xmonad/lib/padding-icon.sh" ["stalonetray"] "tray" 10,
          Run $ Com "pamixer" ["--get-volume"] "" 100,
          Run UnsafeStdinReader
        ],
      sepChar = "*",
      alignSep = "--",
      template = "<action=`dmenu_run` button=1><icon=~/.xmonad/lib/nixos.xpm/></action> *UnsafeStdinReader* " ++ sep ++ " <fn=1></fn>*mpd* -- *multicpu* " ++ sep ++ " *memory* " ++ sep ++ " *dynnetwork* " ++ sep ++ " *battery* " ++ sep ++ " <fn=1>\xf028</fn> <fc=" ++ green ++ ">*pamixer*%</fc> " ++ sep ++ " *date* - *time* " ++ sep ++ "*tray*"
    }

main :: IO ()
main = xmobar config
