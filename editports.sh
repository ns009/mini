echo -e "\e[94m[][][]======================================[][][]"
echo -e "\e[0m                                                   "
echo -e "\e[93m            [1] Edit Port Dropbear"
echo -e "\e[93m            [2] Edit Port Stunnel"
echo -e "\e[93m            [x] Exit"
echo -e "\e[0m                                                   "
echo -e "\e[94m[][][]======================================[][][]\e[0m"
read -p "Masukkan pilihan anda, kemudian tekan ENTER: " option1
	case $option1 in
   			1)
			clear
			editdropbear
			exit
			;;
			2)
			clear
			editstunnel4
			exit
			;;
			x)
			clear
			exit
			;;
	esac
