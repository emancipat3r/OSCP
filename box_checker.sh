#!/bin/bash
# DESCRIPTION: Checks for box responsiveness recursively and lets you know when you get a response

n=1
while ! ping -c1 -w1 $IP &>/dev/null
do
	echo -e "[-] Attempt $n"
	((n=n+1))
	sleep 5
done
echo "[+] Box is up - EXITING.."
