#!/bin/bash

read -p "[*] Enter the target subnet address (e.g. 172.16.1.0/24): " subnet

if (( $# >= 1 ))
	if [ "$EUID" -ne 0 ]
	then
		sudo ip tuntap add user $(whoami) mode tun ligolo
		sudo ip link set ligolo up
		sudo ip route add $subnet dev ligolo
	else
		echo "Please run as root"
		exit
	fi
fi
