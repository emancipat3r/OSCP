#!/bin/bash

read -p "[*] Enter network address (192.168.0): " net
read -p "[*] Enter starting host range (e.g. 1): " start
read -p "[*] Enter ending host range (e.g. 254): " end
read -p "[*] Enter ports space delimited (e.g. 21 22 23 25): " ports

for ((i=$start; $i<=$end; i++))
do
    nc -nzvw1 $net.$i $ports 2>&1 | grep open
done
