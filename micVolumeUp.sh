#!/usr/bin/env bash
[[ "$(pactl get-source-volume @DEFAULT_SOURCE@)" =~ ([0-9]{1,3})% ]]
if [ $? ]
	then if (( ${BASH_REMATCH[1]} < 100))
		then pactl set-source-volume @DEFAULT_SOURCE@ +5%
	fi
fi

