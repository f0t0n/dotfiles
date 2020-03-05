### Common Information

* Create as symbolic link to the service and the timer in /etc/systemd/system
    For example:
    ```
        ln -s /home/f0t0n/dotfiles/services/sync_clouds@.service /etc/systemd/system/sync_clouds@.service
        ln -s /home/f0t0n/dotfiles/services/sync_clouds@.timer /etc/systemd/system/sync_clouds@.timer
        ls -lah /etc/systemd/system | grep sync_clouds
    ```
* Run `systemctl enable <servicename>.timer`
* Start the service once with `systemctl start <servicename>.service`
* Start the service repeatedly with `systemctl start <servicename>.timer`
* If service/timer file was modified run `systemctl daemon-reload`

### Sync clouds service (and timer)

`systemctl enable sync_clouds@google_drive_personal.timer`
`systemctl enable sync_clouds@box.timer`

`systemctl start sync_clouds@google_drive_personal.timer`
`systemctl start sync_clouds@box.timer`
