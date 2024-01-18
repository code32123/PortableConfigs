#!/usr/bin/env bash
[[ "$(pactl get-source-volume alsa_input.usb-Blue_Microphones_Yeti_Nano_2043SG001AM8_888-000154041006-00.analog-stereo)" =~ ([0-9]{1,3})% ]]
if [ $? ]
	then if (( ${BASH_REMATCH[1]} < 100))
		then pactl set-source-volume alsa_input.usb-Blue_Microphones_Yeti_Nano_2043SG001AM8_888-000154041006-00.analog-stereo +5%
	fi
fi

