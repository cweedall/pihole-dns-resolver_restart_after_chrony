systemd_unit_name='pihole-dns-resolver_restart_after_chrony'

touch /lib/systemd/system/$systemd_unit_name.timer

echo "[Unit]" >> /lib/systemd/system/$systemd_unit_name.timer
echo "Description=Timer to restart Pihole DNS resolver after boot" >> /lib/systemd/system/$systemd_unit_name.timer
echo "" >> /lib/systemd/system/$systemd_unit_name.timer
echo "[Timer]" >> /lib/systemd/system/$systemd_unit_name.timer
echo "OnStartupSec=20s" >> /lib/systemd/system/$systemd_unit_name.timer
echo "Unit=$systemd_unit_name.service" >> /lib/systemd/system/$systemd_unit_name.timer
echo "" >> /lib/systemd/system/$systemd_unit_name.timer
echo "[Install]" >> /lib/systemd/system/$systemd_unit_name.timer
echo "WantedBy=timers.target" >> /lib/systemd/system/$systemd_unit_name.timer

touch /lib/systemd/system/$systemd_unit_name.service

echo "[Unit]" >> /lib/systemd/system/$systemd_unit_name.service
echo "Description=Restart Pihole DNS resolver *after* chrony" >> /lib/systemd/system/$systemd_unit_name.service
echo "" >> /lib/systemd/system/$systemd_unit_name.service
echo "[Service]" >> /lib/systemd/system/$systemd_unit_name.service
echo "Type=oneshot" >> /lib/systemd/system/$systemd_unit_name.service
echo "Environment=DISPLAY=:0" >> /lib/systemd/system/$systemd_unit_name.service
echo "Environment=XAUTHORITY=/home/pi/.Xauthority" >> /lib/systemd/system/$systemd_unit_name.service
echo "ExecStart=pihole restartdns" >> /lib/systemd/system/$systemd_unit_name.service
echo "" >> /lib/systemd/system/$systemd_unit_name.service
echo "[Install]" >> /lib/systemd/system/$systemd_unit_name.service
echo "WantedBy=graphical.target" >> /lib/systemd/system/$systemd_unit_name.service
echo "#WantedBy=multi-user.target" >> /lib/systemd/system/$systemd_unit_name.service

systemctl daemon-reload

systemctl enable $systemd_unit_name.service
systemctl enable $systemd_unit_name.timer

echo "You need to reboot for the service to work."
echo "Or, you can run 'sudo systemctl enable $systemd_unit_name.timer' to test it immediately."
