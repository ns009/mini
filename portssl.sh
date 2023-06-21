#!/bin/bash
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'

ssl="$(cat /etc/stunnel/stunnel.conf | grep -i accept | head -n 2 | cut -d= -f2 | sed 's/ //g' | tr '\n' ' ' | awk '{print $1}')"
echo -e "======================================"
echo -e "     [1]  Change Port $ssl"
echo -e "     [x]  MENU"
echo -e "======================================"
echo -e ""
read -p "     Select From Options [1 or x] :  " prot
echo -e ""
case $prot in
1)
read -p "New Port Stunnel4: " stl
if [ -z $stl ]; then
echo "Please Input Port"
exit 0
fi
cek=$(netstat -nutlp | grep -w $stl)
if [[ -z $cek ]]; then
sed -i "s/$ssl/$stl/g" /etc/stunnel/stunnel.conf
sed -i "s/   - Stunnel4                : $ssl/   - Stunnel4                : $stl/g" /root/log-install.txt
/etc/init.d/stunnel4 restart > /dev/null
echo -e "\e[032;1mPort $stl modified successfully\e[0m"
else
echo "Port $stl is used"
fi
;;
x)
menu
;;
*)
echo "Please enter an correct number"
;;
esac
