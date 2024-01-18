#!/usr/bin/env python3
import pulsectl, subprocess

HEADPHONES = [
r"b'alsa_output.usb-Blue_Microphones_Yeti_Nano_2043SG001AM8_888-000154041006-00.analog-stereo\n'",
r"b'alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__hw_sofhdadsp__sink\n'",
]

def run_command(cmd):
	cmd = subprocess.run(cmd, stdout = subprocess.PIPE, stderr = subprocess.DEVNULL, shell=True)
	return str(cmd.stdout)

def printVolumes():
	if "true" == run_command("pamixer --get-mute")[2:-3]:
		print("%{F#707880}muted%{F-}")
		return
	try:
		micVol = run_command("pactl get-source-volume alsa_input.usb-Blue_Microphones_Yeti_Nano_2043SG001AM8_888-000154041006-00.analog-stereo")
		micVolList = micVol.split(" / ")
		micVol = micVolList[1].strip()
	except:
		micVol = None

	spkName = run_command("pactl get-default-sink")
	spkPrefix = "" if spkName in HEADPHONES else ""

	# spkVol = run_command("pactl get-sink-volume $(pactl get-default-sink)")
	# spkVolList = spkVol.split(" / ")
	# spkVol = spkVolList[1].strip()
	spkVol = run_command("pamixer --get-volume-human")[2:-3]
	if spkVol == "muted":
		print("%{F#707880}muted%{F-}")
		return



	print(f"{spkPrefix} {spkVol}" + (f"  {micVol}" if micVol != None else ""), flush=True)

printVolumes()
with pulsectl.Pulse('event-printer') as pulse:
	# print('Event types:', pulsectl.PulseEventTypeEnum)
	# print('Event facilities:', pulsectl.PulseEventFacilityEnum)
	# print('Event masks:', pulsectl.PulseEventMaskEnum)
	def print_events(ev):
		printVolumes()
		### Raise PulseLoopStop for event_listen() to return before timeout (if any)
		# raise pulsectl.PulseLoopStop
	# pulse.event_mask_set(pulsectl.PulseEventMaskEnum.sink, pulsectl.PulseEventMaskEnum.source)
	pulse.event_mask_set(pulsectl.PulseEventMaskEnum.all)
	pulse.event_callback_set(print_events)
	pulse.event_listen(timeout=10)
