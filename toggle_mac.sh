#!/bin/sh

read -p "Kanata Service: (s)top or (r)un?" choice

if [ "$choice" = "r" ]; then
    window_close=$(cat /tmp/kanata_window_id)
    tmux kill-window -t $window_close
    sudo launchctl load /Library/LaunchDaemons/com.kanata.service.plist
elif [ "$choice" = "s" ]; then
    sudo kill $(pgrep -f kanata)
    window_id=$(tmux new-window -P -F "#{window_id}" -n "kanata" bash -c "while true; do sudo ~/kanata/kanata -c ~/kanata/kanata.kdb; done")
    # create a temporary file to store the window id
    echo $window_id > /tmp/kanata_window_id
else
    echo "Invalid choice"
    break
fi

