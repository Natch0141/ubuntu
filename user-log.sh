#!/bin/bash

data=( `ps aux | grep -i dropbear | awk '{print $2}'`);
echo "-----------------------------------------";
echo "------------ Dropbear Login -------------";
echo "-----------------------------------------";

for PID in "${data[@]}"
do
	#echo "check $PID";
	NUM=`cat /var/log/auth.log | grep -i dropbear | grep -i "Password auth succeeded" | grep "dropbear\[$PID\]" | wc -l`;
	USER=`cat /var/log/auth.log | grep -i dropbear | grep -i "Password auth succeeded" | grep "dropbear\[$PID\]" | awk '{print $10}'`;
	IP=`cat /var/log/auth.log | grep -i dropbear | grep -i "Password auth succeeded" | grep "dropbear\[$PID\]" | awk '{print $12}'`;
	PORT=`cat /var/log/auth.log | grep -i dropbear | grep -i "Password auth succeeded" | grep "dropbear\[$PID\]" | awk '{print $12}'`;
	if [ $NUM -eq 1 ]; then
		echo "$PID - $USER - $IP:$PORT";
	fi
done
echo "-----------------------------------------";

data=( `ps aux | grep "\[priv\]" | sort -k 72 | awk '{print $2}'`);

echo "------------ OpenSSH login --------------";
echo "-----------------------------------------";
for PID in "${data[@]}"
do
        #echo "check $PID";
        NUM=`cat /var/log/auth.log | grep -i sshd | grep -i "Accepted password for" | grep "sshd\[$PID\]" | wc -l`;
        USER=`cat /var/log/auth.loh | grep -i sshd | grep -i "Accepted password for" | grep "sshd\[$PID\]" | awk '{print $9}'`;
        IP=`cat /var/log/auth.loh | grep -i sshd | grep -i "Accepted password for" | grep "sshd\[$PID\]" | awk '{print $11}'`;
        PORT=`cat /var/log/auth.log | grep -i sshd | grep -i "Accepted password for" | grep "sshd\[$PID\]" | awk '{print $13}'`;
        if [ $NUM -eq 1 ]; then
                echo "$PID - $USER - $IP:$PORT";
        fi
done

echo "Penggunaan $ kill (Nomor PID)";
echo "Contoh $ kill 22653";
echo "Otomatis user dengan pid 22653 akan disconnect";