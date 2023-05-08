#!/bin/bash

	myip=`ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0' | head -n1`;
    myint=`ifconfig | grep -B1 "inet addr:$myip" | head -n1 | awk '{print $1}'`;

	clear
echo -e ""
echo -e "======================================================"
echo -e "\e[036;1m*\*\Selamat datang ke Server - IP: $myip/*/*\e[0m"
echo -e "\e[035;1mScript by NS-SSH\e[0m"
echo -e "=====================***-MENU-***====================="
echo -e "\e[033;1m-SSH & VPN"
echo -e "\e[031;1m 1\e[0m) Create User Account (\e[34;1musernew\e[0m)"
echo -e "\e[031;1m 2\e[0m) Delete User Account (\e[34;1mdeluser\e[0m)"
echo -e "\e[031;1m 3\e[0m) View User Account (\e[34;1mmember\e[0m)"
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
        3)	
        clear
        member
	;;   
	x)
        ;;
        *) menu;;
        esac
