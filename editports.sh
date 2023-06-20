#!/bin/bash
echo -e "=====================***-MENU-***====================="
echo -e "\e[033;1m-SSH & VPN"
echo -e "\e[031;1m 1\e[0m) Edit Port Dropbear (\e[34;1m\e[0m)"
echo -e "\e[031;1m 2\e[0m) Edit Port Stunnel (\e[34;1m\e[0m)"
echo -e "=====================***-NS-SSH-***===================="
echo -e "\e[031;1mx\e[0m) Exit"
echo -e ""
	read -p "Masukkan pilihan anda, kemudian tekan ENTER: " option1
	case $option1 in
	1)  
        clear
        usernew
        ;;
        2)  
        clear
        deluser
        ;;
        x)
        ;;
        
        esac
