#!/bin/bash
#Script untuk menghapus user SSH & OpenVPN

read -p "Username to be deleted. : " Pengguna

if getent passwd $Pengguna > /dev/null 2>&1; then
        userdel $Pengguna
        echo -e "User $Pengguna Deleted."
else
        echo -e "FAILED: User $Pengguna Not Found."
fi
