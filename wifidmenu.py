#!/usr/bin/env python3
import subprocess

def run_command(cmd):
	# print("CMD", cmd)
	cmd = subprocess.run(cmd, stdout = subprocess.PIPE, stderr = subprocess.PIPE, shell=True)
	return str(cmd.stdout)[2:-1]

networks = run_command("nmcli --get-values=SSID --colors=no d wifi list").split("\\n")

SSIDs = []

for SSID in networks:
	if SSID not in SSIDs and SSID != "":
		SSIDs.append(SSID)

disconnect = "disconnect"

chosenSSID = run_command(f"echo \"{disconnect}\\n" + "\\n".join(SSIDs) + "\" | dmenu -p \"SSID:\"").replace("\\n", "")

if chosenSSID == "":
	exit("No network selected")

if chosenSSID == disconnect:
	wifiDevice = [x.split(":")[0] for x in run_command("nmcli --get-values=DEVICE,TYPE --colors=no d").split("\\n") if x.split(":")[-1] == "wifi"][0]
	run_command(f"nmcli d disconnect {wifiDevice}")
else:
	run_command(f"nmcli d wifi connect \"{chosenSSID}\"")
