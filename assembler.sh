#!/bin/bash

# Purpose of this script is to quickly make elf64 binaries from assembly sorce code.
# If -g is provided as the second positional argument then the binary will be loaded 
# into gdb for analysis

fileName="${1%%.*}" # remove .s extension

nasm -f elf64 ${fileName}".s"
ld ${fileName}".o" -o ${fileName}
if (($#==2)); then
        if (($2=="-g")); then 
                gdb -q ${fileName} || ./${fileName}
        fi
fi
