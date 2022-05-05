## Task 1

We are contracting for a company, and they find a suspicious binary file. We
examine the file with `gdb` and see that it is loading an encoded shellcode to
the Stack and storing the `xor` decoding key in `rbx`. We need to decode the
shellcode after it is loaded to the Stack and then run the shellcode to get the
flag.

---

## Task 2

We are performing a pentest, and in a binary exploitation exercise, we reach the
point where we have to run our shellcode. However, only a buffer space of 50
bytes is available to us. So, we have to optimize our assembly code to make it
shellcode-ready and under 50-bytes to successfully run it on the vulnerable
server.


## Questions

Target: Click here to spawn the target system!  

**Question 1: Disassemble 'loaded_shellcode' and modify its assembly code to
decode the shellcode, by adding a loop to 'xor' each 8-bytes on the stack with
the key in 'rbx'.**
> ANSWER:

``shell

``

> HINT: To loop over the stack, try storing "rsp" in "rdx" and then doing "add rdx, 8" to move to the next 8-bytes on the stack.


**Question 2: The above server simulates a vulnerable server that we can run our
shellcodes on. Optimize 'flag.s' for shellcoding and get it under 50 bytes, then
send the shellcode to get the flag. (Feel free to find/create a custom
shellcode)**
> ANSWER

``shell
```

> HINT: Do we really care about a nice exit?!
