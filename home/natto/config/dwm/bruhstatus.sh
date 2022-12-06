#!/usr/bin/env bash
prevtotload=0
previdleload=0
#tt=$(date +"%s")
#bgfile=$(ls ~/Wallpapers/** | shuf -n 1)
#for N in {99..1}; do
#    magick convert $bgfile -fill black -colorize $N% jpg:- | feh --bg-scale -
#done
#feh --bg-scale $bgfile
while true; do
    cputemp=$(($(cat /sys/class/thermal/thermal_zone0/temp)/1000))
    gputemp=$(nvidia-smi | head -n 10 | tail -n 1 |awk '{print $3}'| cut -c 1-2)
    totmem=$(cat /proc/meminfo | awk '/MemTotal:/ {print $2}')
    echo $totmem
    availmem=$(cat /proc/meminfo | awk '/MemAvailable:/ {print $2}')
    echo $availmem
    totload=$(cat /proc/stat | awk '/cpu/'|head -n 1|awk '{print $2+$3+$4+$5+$6+$7+$8}')
    echo $totload
    idleload=$(cat /proc/stat | awk '/cpu/'|head -n 1|awk '{print $5}')
    echo $idleload
    totloadchange=$(($totload-$prevtotload))
    idleloadchange=$(($idleload-$previdleload))
    xsetroot -name\
        "CPU [$(printf %0.2f $(echo "($totloadchange-$idleloadchange)*100/$totloadchange" | bc -l))%]\
  MEM [$(printf %0.2f $(echo \($totmem - $availmem\)/1024/1024|bc -l))/\
$(printf %0.2f $(echo $totmem/1024/1024 | bc -l))]\
  TEMP [$cputemp°C|$gputemp°C]\
  BAT$($(cat /sys/class/power_supply/BAT1/status | grep -q Discharging) && echo " " || echo "")\
[$(cat /sys/class/power_supply/BAT1/capacity)%]\
  VOL [$(pamixer --get-volume)]\
  [$(date +"%a, %b %d") | $(date +"%H:%M:%S")]"
    prevtotload=$totload
    previdleload=$idleload
   # if [ $(echo $tt+44 | bc -l) -lt $(date +"%s") ]
   # then
        #for N in {1..99}; do
        #    magick convert $bgfile -fill black -colorize $N% jpg:- | feh --bg-scale -
        #done
      #  bgfile=$(ls ~/Wallpapers/** | shuf -n 1)
        #for N in {99..1}; do
        #    magick convert $bgfile -fill black -colorize $N% jpg:- | feh --bg-scale -
        #done    
     #   feh --bg-scale $bgfile
      #  tt=$(date +"%s")
    #fi
    sleep 15
done
