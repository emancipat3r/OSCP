# ENUMERATION COMMANDS

# NMAP
```
# EARLY SCANS
nmap --min-rate 10000 $IP -p- -Pn -oN nmap_tcp_all_quick.txt
nmap -A -T4 $IP -p $PORTS -Pn -oN nmap_tcp_all.txt
sudo nmap -sUV --min-hostgroup 100 $IP -p 1-10000 -oN nmap_udp_quick.txt


# NMAP SCRIPTS
locate *.nse | grep ftp

# NMAP SCRIPT HELP
nmap --script-help ftp-anon

[-] https://nmap.org/book/nse-usage.html
```

# FTP (21)
```
# BANNER GRAB
nc -nv $IP 21

# ANONYMOUS LOGIN
ftp $IP
    USER: anonymous
    PASS: <blank>

# DOWNLOAD ALL FTP DIRS AND FILES
wget --mirror ftp://$IP
wget --no-passive-ftp --mirror ftp://$IP            # If PASV transfer is disabled

# IF UPLOADING EXPLOIT TO FTP ENSURE TO CHANGE MODE TO `BINARY` FIRST
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

# DNS (53)
```
dnsrecon -r 127.0.0.0/24 -n $IP$ -d $Domain_Name
dnsrecon -r $Network/$CIDR -n $IP -d $Domain_Name
dig axfr @$IP
dig axfr $Domain_Name @$IP
nslookup
    SERVER $IP
    127.0.0.1
    $IP
    Domain_Name
    exit
```

# HTTP (80) / HTTPS (443)
```
# DIRECTORY BRUTEFORCE
gobuster dir -u http://$IP:$PORT/$DIR -w $WORDLIST -r -e 
gobuster dir -u http://10.10.10.218/ -w /usr/share/seclists/Discovery/Web-Content/directory-list-2.3-medium.txt -t 50 -r -x txt,html,php
dirsearch -u $IP -e <COMMA SEPARATED EXTENSIONS> -w WORDLIST> -t 30 -r -R 1 -f

# VULNSCAN
nikto -h $IP -C all

# SOFTWARE VERSIONS
whatweb http://$IP:$PORT -a 4
webtech -u $IP

# Open website in browser
```

# RPCBIND (111)
```
rpcinfo $IP         # This can lead to showing nfs on a system (Usually port 2049)
sudo nmap -sSUC -p 111 $IP
```

# MSRPC (135)
```
rpcdump $IP -p 135              # Ensure impacket is installed
```

# SMB (139,445)
```
crackmapexec smb $IP
nbtscan $IP/$CIDR
nmap -p 139,445 --script smb-enum-users $IP
nmap -p 139,445 --script=smb-vuln-* --script-args=unsafe=1 $IP
enum4linux $IP
smbclient -L $IP -N
smbclient \\$IP\$SHARE -N
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

# MSSQL (1433)
```
nmap --script ms-sql-info,ms-sql-empty-password,ms-sql-xp-cmdshell,ms-sql-config,ms-sql-ntlm-info,ms-sql-tables,ms-sql-hasdbaccess,ms-sql-dac,ms-sql-dump-hashes --script-args mssql.instance-port=1433,mssql.username=sa,mssql.password=,mssql.instance-name=MSSQLSERVER -sV -p 1433 $IP
```

# MYSQL (3306)
```
nmap --script=mysql-databases.nse,mysql-empty-password.nse,mysql-enum.nse,mysql-info.nse,mysql-variables.nse,mysql-vuln-cve2012-2122.nse $IP -p 3306
mysql -h $IP -u $USERNAME
```

# RDP (3389)
```
nmap --script "rdp-enum-encryption or rdp-ntlm-info" -p 3389 -T4 <IP>
```
