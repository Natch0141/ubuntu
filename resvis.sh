echo "---------------------";
echo -e "Memulai restart all service";
echo
echo "Restarting cron.....";
/etc/init.d/cron restart
echo "Restarting ssh....";
/etc/init.d/ssh restart
echo "Restarting dropbear....";
/etc/init.d/dropbear restart
echo "Restarting squid";
/etc/init.d/squid3 restart
echo "Restarting webmin";
/etc/init.d/webmin restart
echo "Restarting fail2ban"
/etc/init.d/fail2ban restart
echo "--------------------"
echo -e "Restarting all service berhasil";
