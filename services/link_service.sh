#!/bin/sh

ln -s /home/f0t0n/dotfiles/services/sync_clouds@.service /etc/systemd/system/sync_clouds@.service
ln -s /home/f0t0n/dotfiles/services/sync_clouds@.timer /etc/systemd/system/sync_clouds@.timer
ls -lah /etc/systemd/system | grep sync_clouds
