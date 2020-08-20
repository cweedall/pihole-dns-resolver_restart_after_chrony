systemd_unit_name='pihole-dns-resolver_restart_after_chrony'

systemctl stop $systemd_unit_name.service
systemctl stop $systemd_unit_name.timer

systemctl disable $systemd_unit_name.service
systemctl disable $systemd_unit_name.timer

rm /lib/systemd/system/$systemd_unit_name.timer
rm /lib/systemd/system/$systemd_unit_name.service

systemctl daemon-reload

echo "You have successfully uninstalled $systemd_unit_name.timer and $systemd_unit_name.service."
