#!/usr/bin/python3

import sys
from pwn import *

context(os="Linux", arch="amd64", log_level="error")

file = ELF(sys.argv[1])
shellcode = file.section(".text")
print(shellcode.hex())
