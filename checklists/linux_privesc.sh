#!/bin/bash

function banner {
printf "██╗     ██╗███╗   ██╗██╗   ██╗██╗  ██╗              "
printf "██║     ██║████╗  ██║██║   ██║╚██╗██╔╝              "
printf "██║     ██║██╔██╗ ██║██║   ██║ ╚███╔╝               "
printf "██║     ██║██║╚██╗██║██║   ██║ ██╔██╗               "
printf "███████╗██║██║ ╚████║╚██████╔╝██╔╝ ██╗              "
printf "╚══════╝╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚═╝  ╚═╝              "
printf "                                                    "
printf "██████╗ ██████╗ ██╗██╗   ██╗███████╗███████╗ ██████╗"
printf "██╔══██╗██╔══██╗██║██║   ██║██╔════╝██╔════╝██╔════╝"
printf "██████╔╝██████╔╝██║██║   ██║█████╗  ███████╗██║     "
printf "██╔═══╝ ██╔══██╗██║╚██╗ ██╔╝██╔══╝  ╚════██║██║     "
printf "██║     ██║  ██║██║ ╚████╔╝ ███████╗███████║╚██████╗"
printf "╚═╝     ╚═╝  ╚═╝╚═╝  ╚═══╝  ╚══════╝╚══════╝ ╚═════╝"
}                                   

function divider {
echo "##########################################################"
}

banner
divider

## [1]  OS Information
printf "[SECTION 1] - OS INFORMATION"
printf "https://book.hacktricks.xyz/linux-unix/privilege-escalation#kernel-exploits"
divider
(cat /proc/version || uname -a ) 2>/dev/null
cat /etc/*-release
printf "\n\n"




