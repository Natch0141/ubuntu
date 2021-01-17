OS='uname -m';
IP=$(curl -s https://checkip.amazonaws.com)
#update&&upgrade latest package
apt-get update && apt-get -y upgrade
# go to root
cd

# disable ipv6
echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6
sed -i '$ i\echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6' /etc/rc.local

# install wget and curl
apt-get update;apt-get -y install wget curl;

# set time GMT +7
ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime

# set locale
sed -i 's/AcceptEnv/#AcceptEnv/g' /etc/ssh/sshd_config
service ssh restart
# update
apt-get update

# install webserver
apt-get -y install nginx

# install essential package
apt-get -y install nano iptables dnsutils openvpn screen whois ngrep unzip unrar
# install neofetch
apt-get -y install neofetch
echo "clear" >> .bash_profile
echo "neofetch" >> .bash_profile
#install badvpn/udpgw port default is 7300
cd
wget -O /usr/bin/badvpn-udpgw "http://evira.us/badvpn-udpgw64"
sed -i '$ i\screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 1000' /etc/rc.local
chmod +x /usr/bin/badvpn-udpgw
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300

# setting port ssh
cd
sed -i 's/Port 22/Port 22/g' /etc/ssh/sshd_config
sed -i '/Port 22/a Port 143' /etc/ssh/sshd_config
service ssh restart
# install dropbear
apt-get -y install dropbear
sed -i 's/NO_START=1/NO_START=0/g' /etc/default/dropbear
sed -i 's/DROPBEAR_PORT=22/DROPBEAR_PORT=110/g' /etc/default/dropbear
sed -i 's/DROPBEAR_EXTRA_ARGS=/DROPBEAR_EXTRA_ARGS="-p 109 -p 960"/g' /etc/default/dropbear
echo "/bin/false" >> /etc/shells
echo "/usr/sbin/nologin" >> /etc/shells
service ssh restart
service dropbear restart
# install fail2ban
apt-get -y install fail2ban;
service fail2ban restart
# blockir torrent
iptables -A OUTPUT -p tcp --dport 6881:6889 -j DROP
iptables -A OUTPUT -p udp --dport 1024:65534 -j DROP
iptables -A FORWARD -m string --string "get_peers" --algo bm -j DROP
iptables -A FORWARD -m string --string "announce_peer" --algo bm -j DROP
iptables -A FORWARD -m string --string "find_node" --algo bm -j DROP
iptables -A FORWARD -m string --algo bm --string "BitTorrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "BitTorrent protocol" -j DROP
iptables -A FORWARD -m string --algo bm --string "peer_id=" -j DROP
iptables -A FORWARD -m string --algo bm --string ".torrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "announce.php?passkey=" -j DROP
iptables -A FORWARD -m string --algo bm --string "torrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "announce" -j DROP
iptables -A FORWARD -m string --algo bm --string "info_hash" -j DROP
#install webmin
cd
wget -O /etc/apt/sources.list "https://github.com/Natch0141/ubuntu/blob/master/source.list"
wget http://www.webmin.com/jcameron-key.asc
apt-key add jcameron-key.asc
apt-get update
apt-get -y install webmin
sed -i -e 's/ssl=1/ssl=0/g' /etc/webmin/miniserv.conf
service webmin restart
chkconfig webmin on
#install squid
cd
apt-get -y install squid3
wget -O /etc/squid/squid.conf "https://raw.githubusercontent.com/Natch0141/ubuntu/master/squid.conf"
sed -i 's/acl SSH dst/acl SSH dst $IP/g' /etc/squid/squid.conf
service squid restart
chkconfig squid on
#downlosd
cd /usr/bin
wget -O menu "https://raw.githubusercontent.com/Natch0141/ubuntu/master/menu.sh"
wget -O user-add "https://raw.githubusercontent.com/Natch0141/ubuntu/master/user-add.sh"
wget -O user-del "https://raw.githubusercontent.com/Natch0141/ubuntu/master/user-del.sh"
wget -O user-list "https://raw.githubusercontent.com/Natch0141/ubuntu/master/user-list.sh"
wget -O user-log "https://github.com/Natch0141/ubuntu/blob/master/user-log.sh"
wget -O speedtest "https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py"
echo "0 0 * * * root /sbin/reboot" > /etc/cron.d/reboot
#
chmod +x menu
chmod +x user-add
chmod +x user-del
chmod +x user-list
chmod +x user-log
chmod +x speedtest
#
service cron restart
service ssh restart
service dropbear restart
service squid3 restart
service fail2ban restart
service webmin restart
rm -rf ~/.bash_history && history -c
echo "unset HISTFILE" >> /etc/profile
clear
#success
echo "behasil"
rm -f /root/setup.sh