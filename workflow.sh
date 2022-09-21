#!/bin/bash
# An enumeration workflow script built for OSCP
version="Version 0.001"
test


####################################################
#    COLOR VARIABLES						   	   #
####################################################
#( fg
red='\e[31m'
lred='\e[91m'
green='\e[32m'
lgreen='\e[92m'
yellow='\e[33m'
lyellow='\e[93m'
blue='\e[34m'
lblue='\e[94m'
magenta='\e[35m'
lmagenta='\e[95m'
cyan='\e[36m'
lcyan='\e[96m'
grey='\e[90m'
lgrey='\e[37m'
white='\e[97m'
black='\e[30m'
##)
#( bg
b_red='\e[41m'
b_lred='\e[101m'
b_green='\e[42m'
b_lgreen='\e[102m'
b_yellow='\e[43m'
b_lyellow='\e[103m'
b_blue='\e[44m'
b_lblue='\e[104m'
b_magenta='\e[45m'
b_lmagenta='\e[105m'
b_cyan='\e[46m'
b_lcyan='\e[106m'
b_grey='\e[100m'
b_lgrey='\e[47m'
b_white='\e[107m'
b_black='\e[40m'
##)
#( special
reset='\e[0;0m'
bold='\e[01m'
italic='\e[03m'
underline='\e[04m'
inverse='\e[07m'
conceil='\e[08m'
crossedout='\e[09m'
bold_off='\e[22m'
italic_off='\e[23m'
underline_off='\e[24m'
inverse_off='\e[27m'
conceil_off='\e[28m'
crossedout_off='\e[29m'
##)
#)



####################################################
#    MAIN FUNCTION 							   	   #
####################################################
function main() {
	while :
	do
		case "$1" in
		-h | --help)
			usage
			exit 0
			;;
		-s | --scan)
			IP=$2
			init_scans "$IP"
			exit 0
			;;
		--) # End of all options
			shift
			break
			;;
		-*)
			echo -e "\e[31m\e[01m[Error]\e[00m" "Unknown option $1" >&2
			exit 1
			;;
		*) # No more options
			break
			;;
		esac
	done

}


####################################################
#    HELPER FUNCTION 							   #
####################################################
function usage() {
	echo -e "\e[32m#############################################################\e[00m"
	echo -e "\e[32m#\e[00m" "           \e[34mOSCP Enumeration Automation Script\e[00m            " "\e[32m#\e[00m"
	echo -e "\e[32m#############################################################\e[00m"
	echo -e ""
	echo -e ""
	echo -e "-h, --help		Show this help message"
	echo -e "-s, --scan		Run TCP & UDP nmap scans"
	echo -e ""
	echo -e ""
	echo -e ""
	echo -e ""
	echo -e ""
	echo -e ""
	echo -e ""
	echo -e ""
	echo -e ""
	echo -e ""
	echo -e ""
	echo -e ""
	echo -e ""
	echo -e ""
	echo -e ""
	echo -e ""
	echo -e ""
	echo -e ""
	echo -e ""
	echo -e ""
}




####################################################
#    INITIAL NMAP SCANS						   	   #
####################################################
function init_scans() {	
	if [ "$EUID" -ne 0 ]
	then
		echo "Please run as root"
		exit
	else
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
		sudo nmap -sU --min-hostgroup 100 --min-rate 10000 $IP -p- -oN recon/nmap_udp_quick.txt
		printf "\n+-------------------------------+\n"
	fi
}

####################################################
#    MAIN FUNCTION CALL						   	   #
####################################################
main "$@"
