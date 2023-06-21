#!/bin/bash
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
echo "Checking VPS"
db="$(cat /etc/default/dropbear | grep -i DROPBEAR_PORT | head -n 2 | cut -d= -f2 | sed 's/ //g' | tr '\n' ' ' | awk '{print $1}')"
db2="$(cat /etc/stunnel/stunnel.conf | grep -i connect | head -n 2 | cut -d= -f2 | sed 's/ //g' | tr '\n' ' ' | awk '{print $1}')"
echo -e "======================================"
echo -e "     [1]  Change Port $db"
echo -e "     [x]  MENU"
echo -e "======================================"
echo -e ""
read -p "     Select From Options [1 or x] :  " prot
echo -e ""
case $prot in
1)
read -p "New Port Dropbear: " dbear
if [ -z $dbear ]; then
echo "Please Input Port"
exit 0
fi
cek=$(netstat -nutlp | grep -w $dbear)
if [[ -z $cek ]]; then
sed -i "s/$db/$dbear/g" /etc/default/dropbear
sed -i "s/$db2/$dbear/g" /etc/stunnel/stunnel.conf
sed -i "s/   - Dropbear                : $db/   - Dropbear                : $dbear/g" /root/log-install.txt
/etc/init.d/stunnel4 restart > /dev/null
/etc/init.d/dropbear restart > /dev/null
echo -e "\e[032;1mPort $dbear modified successfully\e[0m"
else
echo "Port $dbear is used"
fi
;;
x)
menu
;;
*)
echo "Please enter an correct number"
;;
esac
