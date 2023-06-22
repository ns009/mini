#!/bin/bash
echo "Checking VPS"
db="$(cat /etc/default/dropbear | grep -i DROPBEAR_PORT | head -n 2 | cut -d= -f2 | sed 's/ //g' | tr '\n' ' ' | awk '{print $1}')"
ssl="$(cat /etc/stunnel/stunnel.conf | grep -i accept | head -n 2 | cut -d= -f2 | sed 's/ //g' | tr '\n' ' ' | awk '{print $1}')"

read -p "Username : " Login
read -p "Password : " Pass
read -p "Expired (hari): " masaaktif

IP=$(wget -qO- icanhazip.com);
echo Script AutoCreate User SSH dan VPN by NS-SSH
sleep 1
echo Ping Host
echo Check Permission...
sleep 0.5
echo Permission Accepted
clear
sleep 0.5
echo Create Account: $Login
sleep 0.5
echo Setting Password: $Pass
sleep 0.5
clear
useradd -e `date -d "$masaaktif days" +"%Y-%m-%d"` -s /bin/false -M $Login
exp="$(chage -l $Login | grep "Account expires" | awk -F": " '{print $2}')"
echo -e "$Pass\n$Pass\n"|passwd $Login &> /dev/null
echo -e ""
echo -e "Thank you for using our service"
echo -e "Info Akaun SSH & OpenVPN"
echo -e "Username       : $Login "
echo -e "Password       : $Pass"
echo -e "==============================="
echo -e "IP Server      : $IP"
echo -e "Dropbear       : $db"
echo -e "SSL/TLS        : $ssl"
echo -e "==============================="
echo -e "Active until   : $exp"
echo -e "Script by NS-SSH"
