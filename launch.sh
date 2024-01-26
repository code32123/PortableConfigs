#!/usr/bin/env bash
# ~/.config/polybar/launch.sh

# Terminate already running bar instances
# If all your bars have ipc enabled, you can use 
polybar-msg cmd quit
# Otherwise you can use the nuclear option:
# killall -q polybar
while pgrep -x polybar >/dev/null; do sleep 0.1; done
# Launch bar1 and bar2
# echo "---" | tee -a /tmp/polybar1.log
# polybar 2>&1 | tee -a /tmp/polybar1.log & disown
for m in $(polybar --list-monitors | cut -d":" -f1); do
	echo $m
	polybar $m -l error & disown
    # MONITOR=$m polybar --reload example &
done
# polybar & disown

# echo "Bars launched..."