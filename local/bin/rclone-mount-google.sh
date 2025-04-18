#!/bin/bash
mkdir -p $HOME/Documents/google-drive
chmod 777 $HOME/Documents/google-drive
umount $HOME/Documents/google-drive
rclone mount google: $HOME/Documents/google-drive --vfs-cache-mode=full --dir-cache-time=5000h --poll-interval=10s --rc --rc-addr=:5572 --rc-no-auth --drive-pacer-min-sleep=10ms --drive-pacer-burst=200
