#/usr/bin/env sh

rclone sync dropbox:password google_drive_personal:Dropbox/password
rclone sync dropbox:password box:Dropbox/password
