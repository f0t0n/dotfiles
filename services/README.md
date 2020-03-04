* Create as symbolic link to the service in /etc/systemd/system
* Run `systemctl enable <servicename>.service`
* Start the service with `systemctl start <servicename.service>
* If service file changed run `systemctl daemon-reload`
