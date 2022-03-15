#!/bin/bash

if [ "$EUID" -ne 0 ]
then
    echo "Please run as root"
    exit
else
    if [ -z "$1" ]
    then
	    printf "USAGE: ./init_scans.sh <IP>"
    else
        IP=$1

	    echo "[*] Running TCP quick scan"

    	ports=`nmap --min-rate 10000 $IP -p- -Pn -oN recon/nmap_tcp_all_quick.txt | awk -F "/" '{if ($1 ~ /^[:0-9:]/) print $1}' | paste -d, -s -`
    	printf "\n[*] $(echo $IP) - OPEN PORTS\n"
    	echo "------------------------------"
	    printf "\t[-] $ports\n\n\n"

    	echo "[*] Running TCP -A scan"
    	printf "\n+-------------------------------+\n"
    	nmap -A -T4 $IP -p $ports -Pn -oN recon/nmap_tcp_all.txt
    	printf "\n+-------------------------------+\n\n\n"

    	echo "[*] Running UDP -sC scan"
    	printf "\n+-------------------------------+\n"
    	sudo nmap -sU --min-hostgroup 100 $IP -oN recon/nmap_udp_quick.txt
    	printf "\n+-------------------------------+\n"
    fi
fi
