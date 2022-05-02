#!/bin/bash

# Purpose of this script is to quickly make elf64 binaries from assembly sorce code.
# If -g is provided as the second positional argument then the binary will be loaded
# into gdb for analysis

fileName="${1%%.*}" # remove .s extension

if [ -z "$2" ]; then
	nasm -f elf64 ${fileName}".s"
	ld ${fileName}".o" -o ${fileName}
fi

if [ $2 == '-g' ]; then
	gdb -q ${fileName} || ./${fileName}
fi

if [ $2 == '-d'  ]; then
	nasm -f elf64 ${fileName}".s"
	ld ${fileName}".o" -o ${fileName} -lc --dynamic-linker /lib64/ld-linux-x86-64.so.2
fi
