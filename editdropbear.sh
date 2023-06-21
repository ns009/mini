#!/bin/bash
rm -f /root/dropbearport
rm -f /root/stunnel4port
rm /etc/stunnel/stunnel.conf
dropbearport="$(netstat -nlpt | grep -i dropbear | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"
stunnel4port="$(netstat -nlpt | grep -i stunnel | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"
dropbearport2="s/xxxxx/$dropbearport/g"
echo $dropbearport > /root/dropbearport
cat > /root/dropbearport <<-END
$dropbearport
END
echo $stunnel4port > /root/stunnel4port
cat > /root/stunnel4port <<-END
$stunnel4port
END
cd
cat > /etc/stunnel/stunnel.conf <<-END
cert = /etc/stunnel/stunnel.pem
client = no
socket = a:SO_REUSEADDR=1
socket = l:TCP_NODELAY=1
socket = r:TCP_NODELAY=1

[dropbear]
accept = 443
connect = xxxxx
END
clear
echo -e "\e[0m                                                   "
echo -e "\e[94m[][][]======================================[][][]"
echo -e "\e[0m                                                   "
echo -e "\e[93m                  Dropbear  Ports                 "
echo -e "\e[93m                   "$dropbearport
echo -e "\e[0m                                                   "
read -p "       Which Port Should Be Changed? :  " Port
egrep "^$Port" /root/dropbearport >/dev/null
if [ $? -eq 0 ]; then
	read -p "            From Port $Port -> Port " Port_New
	if grep -Fxq $Port_New /root/stunnel4port; then
		echo -e "\e[0m                                                   "
		echo -e "\e[91m              Stunnel4 Port Conflict              "
		echo -e "\e[91m              Port Is Already In Use              "
		echo -e "\e[0m                                                   "
		echo -e "\e[94m[][][]======================================[][][]\e[0m"
		exit
	fi
	Port_Change="s/$Port/$Port_New/g";
	sed -i $Port_Change /etc/default/dropbear

	service dropbear restart > /dev/null
	rm -f /root/dropbear
	dropbearport="$(netstat -nlpt | grep -i dropbear | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"
	clear
	echo -e "\e[0m                                                   "
	echo -e "\e[94m[][][]======================================[][][]"
	echo -e "\e[0m                                                   "
	echo -e "\e[93m                  Dropbear  Ports                 "
	echo -e "\e[93m                   "$dropbearport
	echo -e "\e[0m                                                   "
	echo -e "\e[94m[][][]======================================[][][]\e[0m"

else
	clear
	echo -e "\e[0m                                                   "
	echo -e "\e[91m                 Port Doesnt Exit                 "
	echo -e "\e[0m                                                   "
	echo -e "\e[94m[][][]======================================[][][]\e[0m"
fi

