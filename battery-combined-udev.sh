#!/bin/bash

battery_print() {
    PATH_AC="/sys/class/power_supply/ADP1"
    PATH_BATTERY="/sys/class/power_supply/BAT1"

    ac=0
    battery_level=0
    battery_max=0

    if [ -f "$PATH_AC/online" ]; then
        ac=$(cat "$PATH_AC/online")
    fi

    if [ -f "$PATH_BATTERY/energy_now" ]; then
        battery_level=$(cat "$PATH_BATTERY/energy_now")
    fi

    if [ -f "$PATH_BATTERY/energy_full" ]; then
        battery_max=$(cat "$PATH_BATTERY/energy_full")
    fi

    battery_percent=$(("$battery_level * 100"))
    battery_percent=$(("$battery_percent / $battery_max"))

    if [ "$ac" -eq 1 ]; then
        if [ "$battery_percent" -gt 99 ]; then
            echo "+100%"
        else
            echo "+$battery_percent%"
        fi
    else
        if [ "$battery_percent" -gt 15 ]; then
            echo "$battery_percent%"
        else
            echo "%{F#e64c4c}$battery_percent%%{F-}"
        fi

        
    fi
}

path_pid="/tmp/polybar-battery-combined-udev.pid"

case "$1" in
    --update)
        pid=$(cat $path_pid)

        if [ "$pid" != "" ]; then
            kill -10 "$pid"
        fi
        ;;
    *)
        echo $$ > $path_pid

        trap exit INT
        trap "echo" USR1

        while true; do
            battery_print

            sleep 30 &
            wait
        done
        ;;
esac
