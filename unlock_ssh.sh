#!/bin/sh

nvram set ssh_en=1
nvram set uart_en=1
nvram set boot_wait=on
nvram commit

# Open custom SSH port
uci add firewall rule
uci set firewall.@rule[-1].name=Allow-Inbound-SSH
uci set firewall.@rule[-1].src=wan
uci set firewall.@rule[-1].target=ACCEPT
uci set firewall.@rule[-1].proto=tcp
uci set firewall.@rule[-1].dest_port=2222
uci set firewall.@rule[-1].enabled=1
uci commit firewall
/etc/init.d/firewall reload

# Start Dropbear
cp /etc/init.d/dropbear /etc/init.d/dropbear_backup
sed -i '/flg_ssh.*release/ { :a; N; /fi/! ba };/return 0/d' /etc/init.d/dropbear

# Set default password
echo -e 'admin\nadmin' | passwd root
/etc/init.d/dropbear enable
/etc/init.d/dropbear start

# Set Dropbear to use custom port instead of default (22)
uci set dropbear.@dropbear[0].Port=2222
uci commit dropbear
/etc/init.d/dropbear reload

# Try to preserve modified dropbear file on upgrade
echo "/etc/init.d/dropbear" >> /etc/sysupgrade.conf

reboot
