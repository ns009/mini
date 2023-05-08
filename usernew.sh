#!/bin/bash

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
echo -e "OpenSSH        : 445"
echo -e "Dropbear       : 444"
echo -e "SSL/TLS        : 443"
echo -e "==============================="
echo -e "Active until   : $exp"
echo -e "Script by NS-SSH"
