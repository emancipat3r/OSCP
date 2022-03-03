# PRE-SCAN ENVIRONMENTAL VARIABLES
```
# SET THESE BEFORE SCANNING
IP = <IP ADDDR>
BOX = <HOSTNAME>
```

# INITIAL SCANS
```
# QUICK CHECK TO SEE WHAT TCP PORTS ARE OPEN
nmap --min-rate 10000 $IP -p- -Pn -oN recon/nmap_tcp_quick.txt

# CHECK TO SEE WHAT UDP PORTS ARE OPEN - RUN IN BACKGROUND
sudo nmap -sU -sV $IP -p 1-1024 -Pn -oN recon/nmap_udp_quick.txt

# NMAP DEFAULT SCRIPTS, SERVICE VERSION, AND OS CHECK SCAN FOR TCP PORTS THAT WERE DISCOVERED OPEN
nmap -A -T4 $IP -p <OPEN_PORTS> -Pn -oN recon/nmap_tcp_full.txt
```

# FTP - 21
```
# TRY ANONYMOUS LOGIN - NMAP SHOULD TELL YOU IF ANON LOGIN IS ENABLED
ftp $IP
    > anonymous
    > anonymous
    > ls -a               # List all files (even hidden) (yes, they could be hidden)
    > binary              # Set transmission to binary instead of ascii - USEFUL FOR MOVING BINARIES TO TARGET BOX
    > ascii               # Set transmission to ascii instead of binary
    > bye                 # Exit


wget -r ftp://$IP
```

# HTTP - 80 / HTTPS 443
```

```

# BRUTEFORCE
```

```
