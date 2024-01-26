#!/usr/bin/env python3
import subprocess

def run_command(cmd):
	# print("CMD", cmd)
	cmd = subprocess.run(cmd, stdout = subprocess.PIPE, stderr = subprocess.PIPE, shell=True)
	return str(cmd.stdout)[2:-1]

NotificationId = run_command("notify-send --urgency=low -i 0 \"Goin' on a wifi hunt...\" -p")[:-2]
print("NotifID", NotificationId)

networks = run_command("nmcli --get-values=SSID --colors=no d wifi list --rescan yes").split("\\n")

SSIDs = []

for SSID in networks:
	if SSID not in SSIDs and SSID != "":
		SSIDs.append(SSID)

disconnect = "disconnect"

chosenSSID = run_command(f"echo \"{disconnect}\\n" + "\\n".join(SSIDs) + "\" | dmenu -p \"SSID:\"").replace("\\n", "")

if chosenSSID == "":
	run_command(f"notify-send --urgency=low -i 0 \"Canceled.\" -r {NotificationId}")
	exit("No network selected")

if chosenSSID == disconnect:
	run_command(f"notify-send --urgency=low -i 0 \"Disconnecting...\" -r {NotificationId}")
	wifiDevice = [x.split(":")[0] for x in run_command("nmcli --get-values=DEVICE,TYPE --colors=no d").split("\\n") if x.split(":")[-1] == "wifi"][0]
	run_command(f"nmcli d disconnect {wifiDevice}")
else:
	run_command(f"notify-send --urgency=low -i 0 \"Connecting to {chosenSSID}...\" -r {NotificationId}")
	run_command(f"nmcli d wifi connect \"{chosenSSID}\"")
