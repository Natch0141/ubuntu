echo "---------------------";
echo -e "Memulai restart all service";
echo
echo "Restarting cron...";
/etc/init.d/cron restart
echo "Restarting ssh....";
/etc/init.d/ssh restart
echo "Restarting dropbear...";
/etc/init.d/dropbear restart
echo "Restarting stunnel4...";
/etc/init.d/stunnel4 restart
echo "Restarting openvpn....";
/etc/init.d/openvpn restart
echo "Restarting squid...";
/etc/init.d/squid restart
echo "Restarting webmin...";
/etc/init.d/webmin restart
echo "Restarting fail2ban..."
/etc/init.d/fail2ban restart
echo "--------------------"
echo -e "Restarting all service berhasil";
