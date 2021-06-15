Config {
    position = Static { xpos = 0 , ypos = 0, width = 1805, height = 23 },
    font = "xft:Fira Mono:style=Regular:antialias=true:pixelsize=16"
    additionalFonts = [ "xft:Font Awesome 5 Free Solid:pixelsize=15", "xft:Font Awesome 5 Brands:pixelsize=15" ]
    bgColor = "#1d2021",
    fgColor = "#d5c4a1",
    lowerOnStart = False,
    overrideRedirect = False,
    allDesktops = True,
    persistent = True,
    commands = [
        Run MultiCpu ["-t","<fn=1>\xf2db</fn> <total>","-L","20","-H","80","-h","#D3869B","-l","#8EC07C","-n","#EBDBB2"] 10,
        Run Memory ["-t","<fn=1>\xf538</fn> <usedratio>","-H","12288","-L","6144","-h","#D3869B","-l","#8EC07C","-n","#EBDBB2"] 10,
        Run Network "wlp0s20f3" ["-t","<fn=1>\xf1eb</fn> <fc=#fabd2f><rx>/<tx></fc>"] 10,
        Run Date "<fn=1>\xf073</fn> %b, %_d ║%l:%M:%S " "date" 10,
        Run MPD ["-t", "<fn=1>\xf001</fn> <state>: <title>", "--", "-P", ">>", "-Z", "|", "-S", "><", "-h", "127.0.0.1", "-p", "6600"] 10,
        Run Com "pamixer" ["--get-volume"] "" 10,
        Run UnsafeStdinReader
    ],
    sepChar = "*",
    alignSep = "--",
    template = "*UnsafeStdinReader* ║ *mpd* -- *multicpu*% ║ *memory*% ║ *wlp0s20f3* ║ <fn=1></fn> <fc=#83a598>*pamixer*%</fc> ║ <fc=#ebdbb2>*date*</fc>"
}

