#!/bin/bash
#Script auto create user SSH
clear
read -p "Username : " Login
read -p "Password : " Pass
read -p "Expired (hari): " masaaktif

IP=$(curl -s https://checkip.amazonaws.com)
useradd -e `date -d "$masaaktif days" +"%Y-%m-%d"` -s /bin/false -M $Login
exp="$(chage -l $Login | grep "Account expires" | awk -F": " '{print $2}')"
echo -e "$Pass\n$Pass\n"|passwd $Login &> /dev/null
echo -e ""
echo -e "Informasi SSH"
echo -e "=========-account-=========="
echo -e "Host: $IP" 
echo -e "Port OpenSSH : 22, 143"
echo -e "Port Dropbear : 110, 109, 960"
echo -e "Port Squid : 8080, 3128"
echo -e "Port Stunnel : 443, 990"
echo -e "Port OpenVPN : 1194(tcp), 24522(udp)"
echo -e "Username: $Login "
echo -e "Password: $Pass"
echo -e "-----------------------------"
echo -e "Aktif Sampai: $exp"
echo -e "==========================="