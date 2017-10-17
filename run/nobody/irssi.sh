#!/bin/bash

# if autodl-irssi enabled then run, else log
if [[ "${ENABLE_AUTODL_IRSSI}" == "yes" ]]; then

	# enable autodl-plugin
	sed -i -r '/^\[autodl-irssi\]/!b;n;cenabled = yes' /config/rutorrent/conf/plugins.ini

	# change directory to script location and then run irssi via tmux
	cd /home/nobody/.irssi/scripts/autorun

	# create tmux session name 'irssi_session' and window name 'irssi_window'
	# note the window number starts at 0
	tmux new-session -d -s irssi_session -n irssi_window /usr/bin/irssi

	# send command to update trackers using tmux send-keys command sent to
	# the session name and window number (0 in this case)
	tmux send-keys -t irssi_session:0 "/autodl update" ENTER

else

	# disable autodl-plugin
	sed -i -r '/^\[autodl-irssi\]/!b;n;cenabled = no' /config/rutorrent/conf/plugins.ini

	echo "[info] Autodl-irssi not enabled, skipping startup"

fi