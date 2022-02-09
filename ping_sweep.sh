#!/bin/bash


## Gather User Input
read -p "[*] Enter the network address (e.g. 192.168.0): " net
read -p "[*] Enter the starting host range (e.g. 1): " start
read -p "[*] Enter the ending host range (e.g. 254): " end

if (($#>=1))
then
    read -p "[*] Where would you like to save the output?: " path
    for i in `seq $start $end`
    do
        (ping -c 1 -W2 $net.$i | grep "bytes from" | cut -d " " -f 4 | tr -d ":" &) >> $path$1
    done
else
    for i in `seq $start $end`
    do
        (ping -c 1 -W2 $net.$i | grep "bytes from" | cut -d " " -f 4 | tr -d ":" &)
    done
fi
