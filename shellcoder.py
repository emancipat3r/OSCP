#!/usr/bin/python3

import sys
from pwn import *

context(os="Linux", arch="amd64", log_level="error")

file = ELF(sys.argv[1])
shellcode = file.section(".text")
print(shellcode.hex())
print("%d bytes - Found NULL byte" % len(shellcode)) if [i for i in shellcode if i == 0] else print("%d bytes - No NULL bytes" % len(shellcode))
