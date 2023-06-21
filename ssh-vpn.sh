#!/bin/bash
# By NS-SSH
# 
# ==================================================

# initializing var
export DEBIAN_FRONTEND=noninteractive
MYIP=$(wget -qO- ifconfig.co);
NET=$(ip -o $ANU -4 route show to default | awk '{print $5}');
source /etc/os-release
ver=$VERSION_ID

#detail nama perusahaan
country=NS
state=NS
locality=NS
organization=NS
organizationalunit=NS
commonname=NS
email=NS

# go to root
cd

# set time GMT +8
ln -fs /usr/share/zoneinfo/Asia/Kuala_Lumpur /etc/localtime

# set locale
sed -i 's/AcceptEnv/#AcceptEnv/g' /etc/ssh/sshd_config

# install
apt-get --reinstall --fix-missing install -y screen neofetch git
echo "clear" >> .profile
echo "neofetch" >> .profile
echo "echo by NS-SSH" >> .profile

# install dropbear
apt -y install dropbear
sed -i 's/NO_START=1/NO_START=0/g' /etc/default/dropbear
sed -i 's/DROPBEAR_PORT=22/DROPBEAR_PORT=444/g' /etc/default/dropbear
echo "/bin/false" >> /etc/shells
echo "/usr/sbin/nologin" >> /etc/shells
/etc/init.d/dropbear restart

# install stunnel
apt install stunnel4 -y
cat > /etc/stunnel/stunnel.conf <<-END
cert = /etc/stunnel/stunnel.pem
client = no
socket = a:SO_REUSEADDR=1
socket = l:TCP_NODELAY=1
socket = r:TCP_NODELAY=1

[dropbear]
accept = 443
connect = 444

END

# make a certificate
openssl genrsa -out key.pem 2048
openssl req -new -x509 -key key.pem -out cert.pem -days 1095 \
-subj "/C=$country/ST=$state/L=$locality/O=$organization/OU=$organizationalunit/CN=$commonname/emailAddress=$email"
cat key.pem cert.pem >> /etc/stunnel/stunnel.pem

# configure stunnel
#sed -i '$ i\ENABLED=1' /etc/default/stunnel4
#sed -i 's/ENABLED=0/ENABLED=1/g' /etc/default/stunnel4
/etc/init.d/stunnel4 restart
systemctl enable stunnel4

# download script
cd /usr/bin
wget -O menu "https://raw.githubusercontent.com/ns009/mini/main/menu.sh"
wget -O usernew "https://raw.githubusercontent.com/ns009/mini/main/usernew.sh"
wget -O member "https://raw.githubusercontent.com/ns009/mini/main/member.sh"
wget -O delete "https://raw.githubusercontent.com/ns009/mini/main/deluser.sh"
wget -O editdropbear "https://raw.githubusercontent.com/ns009/mini/main/editdropbear.sh"
wget -O editstunnel4 "https://raw.githubusercontent.com/ns009/mini/main/editstunnel4.sh"

chmod +x menu
chmod +x usernew
chmod +x member
chmod +x deluser
chmod +x editdropbear
chmod +x editstunnel4

# menu auto load
sed -i '$ i\menu' ~/.bashrc

# finishing
cd
chown -R www-data:www-data /home/vps/public_html

/etc/init.d/ssh restart
/etc/init.d/dropbear restart
/etc/init.d/stunnel4 restart

history -c
echo "unset HISTFILE" >> /etc/profile

cd
rm -f /root/ssh-vpn.sh

# finihsing
clear
neofetch
netstat -nutlp
