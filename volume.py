#!/usr/bin/env python3
import pulsectl, subprocess

HEADPHONES = [
r"b'alsa_output.usb-Blue_Microphones_Yeti_Nano_2043SG001AM8_888-000154041006-00.analog-stereo\n'",
]

def run_pactl_command(cmd):
	cmd = subprocess.run(cmd, stdout = subprocess.PIPE, shell=True)
	return str(cmd.stdout)

def printVolumes():
	try:
		micVol = run_pactl_command("pactl get-source-volume 50")
		micVolList = micVol.split(" / ")
		micVolLeft = micVolList[1].strip()
	except:
		micVolLeft = None

	spkName = run_pactl_command("pactl get-default-sink")
	spkPrefix = "" if spkName in HEADPHONES else ""

	spkVol = run_pactl_command("pactl get-sink-volume $(pactl get-default-sink)")
	spkVolList = spkVol.split(" / ")
	spkVolLeft = spkVolList[1].strip()


	print(spkPrefix, spkVolLeft, (" " + micVolLeft) if micVolLeft != None else "", flush=True)

printVolumes()
with pulsectl.Pulse('event-printer') as pulse:
	# print('Event types:', pulsectl.PulseEventTypeEnum)
	# print('Event facilities:', pulsectl.PulseEventFacilityEnum)
	# print('Event masks:', pulsectl.PulseEventMaskEnum)
	def print_events(ev):
		printVolumes()
		### Raise PulseLoopStop for event_listen() to return before timeout (if any)
		# raise pulsectl.PulseLoopStop
	pulse.event_mask_set(pulsectl.PulseEventMaskEnum.sink, pulsectl.PulseEventMaskEnum.source)
	pulse.event_callback_set(print_events)
	pulse.event_listen(timeout=30)
