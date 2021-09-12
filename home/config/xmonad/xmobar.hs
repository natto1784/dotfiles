Config {
    position = Static { xpos = 0 , ypos = 0, width = 1805, height = 23 },
    font = "xft:Fira Mono:style=Regular:antialias=true:pixelsize=16,Font Awesome 5 Brands:pixelsize=16,Font Awesome 5 Free:pixelsize=16:style=Solid,Lohit Devanagari:style=Regular:pixelsize=16,Lohit Gurmukhi:style=Regular:pixelsize=16,Noto Sans CJK JP:style=Regular:pixelsize=16,Noto Sans CJK KR:style=Regular:pixelsize=16,Noto Sans CJK SC:style=Regular:pixelsize=16"
    additionalFonts = [ "xft:Font Awesome 5 Free:pixelsize=15:style=Solid", 
                        "xft:Font Awesome 5 Brands:pixelsize=15"
                      ]
    bgColor = "#1d2021",
    fgColor = "#d5c4a1",
    lowerOnStart = False,
    overrideRedirect = False,
    allDesktops = True,
    persistent = True,
    commands = [
        Run MultiCpu ["-t","<fn=1>\xf2db</fn> <total>%","-L","20","-H","80","-h","#D3869B","-l","#8EC07C","-n","#EBDBB2"] 10,
        Run Memory ["-t","<fn=1>\xf538</fn> <usedratio>%","-H","12288","-L","6144","-h","#D3869B","-l","#8EC07C","-n","#EBDBB2"] 20,
        Run BatteryP ["BAT1","BAT0","BAT2"] ["-t", "<acstatus>", "-L", "10", "-H", "80", "-l", "#D3869B", "-h", "#8EC07C", "-n", "#EBDBB2", "--", "-O", "Charging", "-o", "<left>%", "-a", "notify-send -u critical 'Battery running out!'", "-A", "5", "--lows", "<fn=1>\xf243</fn> ", "--mediums", "<fn=1>\xf242</fn> ", "--highs", "<fn=1>\xf240</fn> "] 300,
        Run Network "wlp0s20f3" ["-t","<fn=1>\xf1eb</fn> <fc=#fabd2f><rx>/<tx></fc>"] 10,
        Run Date "<fn=1>\xf073 </fn> %a - %b, %_d ║ %H:%M:%S " "date" 100,
        Run MPD ["-t", "<statei><title>", "--", "-P", ">> ", "-Z", "|| ", "-S", "Stopped", "-h", "127.0.0.1", "-p", "6600"] 10,
 --       Run Com "playerctl" ["--player", "playerctld", "metadata", "--format", "{{status}}: {{title}}"] "" 10,
        Run Com "pamixer" ["--get-volume"] "" 600,
        Run UnsafeStdinReader
    ],
    sepChar = "*",
    alignSep = "--",
    template = "<action=`dmenu_run` button=1><icon=/home/natto/.xmonad/lib/nixos.xpm/></action> *UnsafeStdinReader* | <fn=1></fn> *mpd* -- *multicpu* | *memory* | *wlp0s20f3* | *battery* | <fn=1></fn> <fc=#83a598>*pamixer*%</fc> | <fc=#ebdbb2>*date*</fc>"
}

