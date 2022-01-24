#!/bin/bash
# Basic Port Scanner
# usage = ./portscan.sh <IP>

function banner {
echo "    ____  ____  ____  ______   _____ _________    _   __  "
echo "   / __ \/ __ \/ __ \/_  __/  / ___// ____/   |  / | / /  "
echo "  / /_/ / / / / /_/ / / /     \__ \/ /   / /| | /  |/ /   "
echo " / ____/ /_/ / _, _/ / /     ___/ / /___/ ___ |/ /|  /    "
echo "/_/    \____/_/ |_| /_/     /____/\____/_/  |_/_/ |_/     "
echo "                                                          "
echo "                                                          "
}

function divider {
echo "##########################################################"
}


banner
divider
LADDR=$(/sbin/ip -o -4 addr list tun0 | awk '{print $4}' | cut -d/ -f1)
echo "LADDR: $LADDR"
ping -c2 $1 &> /dev/null && echo -e "$1 is ONLINE" || echo -e "$1 is OFFLINE"
divider
printf "\n"

printf "~~~~~~~~~~~~~// INITIAL INFORMATION //~~~~~~~~~~~~~~\n"
read -p "[*] what is the name of the box? " name
echo $name
printf "\n"

printf "~~~~~~~~~~~~~// DIRECTORY CHECKS //~~~~~~~~~~~~~~~~~\n"
if [[ ! -d ~/boxes/"$name" ]]; then
        mkdir -p ~/boxes/"$name"
        cd ~/boxes/"$name"
        printf "[*] Directory created\n\n"
else
        cd ~/boxes/"$name"
        printf "[*] Directory exists\n\n"
fi

printf "~~~~~~~~~~~~~// SOFTWARE CHECKS //~~~~~~~~~~~~~~~~~~\n"
# nmap check
if ! command -v nmap &> /dev/null; then
        read -p '[!] nmap is not installed. Do you want to install? (y/n) ' ans1
        if [[ $ans1 == "y" || $ans1 == "Y" ]]; then
                sudo apt-get install nmap -y
        fi
fi

# rustscan check
if ! command -v rustscan &> /dev/null; then
read -p '[!] rustscan is not installed. Do you want to install? (y/n) ' ans2
        if [[ $ans2 == "y" || $ans2 == "Y" ]]; then
                wget https://github.com/RustScan/RustScan/releases/download/2.0.1/rustscan_2.0.1_amd64.deb
                sudo dpkg -i rustscan_2.0.1_amd64.deb
        fi
fi
printf "[*] Requisite software installed\n\n"

printf "~~~~~~~~~~~~~// SCANNING //~~~~~~~~~~~~~~~~~~~~~~~\n"
printf "[RUNNING - RUSTSCAN] rustscan -a 10.11.1.5 --ulimit 500 --scripts none\n"
rustscan -a $1 --ulimit 500 --scripts none > "$name"_rustscan.txt
ports=$(cat "$name"_rustscan.txt | grep ^[0-9] | cut -d "[" -f2 | cut -d "]" -f1)
echo "====> PORTS:"
echo "      $ports"
printf "\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
printf "\n[RUNNING - NMAP DEFAULT SCRIPTS] nmap -A -T4 $1 -p $ports \n"
nmap -A -T4 $1 -p $ports | awk '/^PORT/ || /^[0-9]/ || /script/ || /^[|]/'
printf "\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
printf '\n[RUNNING - NMAP VULN SCRIPTS] nmap '$1' -p '$ports' --script="*vuln*"\n'
nmap $1 -p $ports --script="*vuln*" | awk '/script/ || /^[|]/' 
