#!/usr/bin/env python3

import subprocess

# Set target IP or hostname
target = "192.168.1.1"

def menu():
  print("\nEnumeration Menu\n")
  print("1. Identify open ports and services")
  print("2. Identify operating system and version")
  print("3. Scan for known vulnerabilities")
  print("4. Enumerate HTTP services")
  print("5. Enumerate DNS services")
  print("6. Enumerate SMB services")
  print("7. Enumerate FTP services")
  print("8. Enumerate SNMP services")
  print("9. Enumerate SSL/TLS services")
  print("10. Quit\n")

def main():
  while True:
    menu()
    choice = input("Enter your choice: ")

    if choice == "1":
      # Identify open ports and services
      print("\nScanning for open ports and services...")
      subprocess.run(["nmap", "-p-", target])
    elif choice == "2":
      # Identify operating system and version
      print("\nIdentifying operating system and version...")
      subprocess.run(["nmap", "-O", target])
    elif choice == "3":
      # Scan for known vulnerabilities
      print("\nScanning for known vulnerabilities...")
      subprocess.run(["nmap", "--script", "vuln", target])
    elif choice == "4":
      # Enumerate HTTP services
      print("\nEnumerating HTTP services...")
      subprocess.run(["gobuster", "-u", f"http://{target}", "-w", "/usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt"])
    elif choice == "5":
      # Enumerate DNS services
      print("\nEnumerating DNS services...")
      subprocess.run(["dig", target])
      subprocess.run(["nslookup", target])
      subprocess.run(["dnsenum", target])
    elif choice == "6":
      # Enumerate SMB services
      print("\nEnumerating SMB services...")
      subprocess.run(["nmap", "--script", "smb-enum*", target])
      subprocess.run(["enum4linux", target])
    elif choice == "7":
      # Enumerate FTP services
      print("\nEnumerating FTP services...")
      subprocess.run(["nmap", "--script", "ftp-anon,ftp-bounce,ftp-libopie,ftp-proftpd-backdoor,ftp-vsftpd-backdoor", target])
    elif choice == "8":
      # Enumerate SNMP services
      print("\nEnumerating SNMP services...")
      subprocess.run(["snmp-check", target])
      subprocess.run(["onesixtyone", target])
    elif choice == "9":
      # Enumerate SSL/TLS services
      print("\nEnumerating SSL/TLS services...")
      subprocess.run(["ssl-scan", target])
      subprocess.run(["testssl.sh", target])
    else:
      print("Enter a correct choice next time...")
      break
      
      
if __name__ == "__main__":
  menu()
  main()
  print("Enumeration complete")
