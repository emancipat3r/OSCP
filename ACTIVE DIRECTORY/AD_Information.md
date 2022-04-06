# Active Directory

## Active Directory Overview
**Active Directory (AD)** is a directory service developed by Microsoft for Windows domain networks. It is included in most Windows Server operating systems as a set of processes and services. Initially, AD was used only for centralized domain management. However, AD eventually became an umbrella title for a broad range of directory-based identity-related services.

A server running the **Active Directory Domain Service (AD DS)** role is called a domain controller. It authenticates and authorizes all users and computers in a Windows domain type network, assigning and enforcing security policies for all computers, and installing or updating software. For example, when a user logs into a computer that is part of a Windows


---
## Active Directory Enumeration
- https://posts.specterops.io/an-introduction-to-manual-active-directory-querying-with-dsquery-and-ldapsearch-84943c13d7eb

---
## Active Directory Attacks

### LDAP Anonymous Bind
- LDAP anonymous binds allow unauthenticated attackers to retrieve information from the domain, such as a full listing of users, groups, computers, user account attributes, and the domain password policy. Linux hosts running open-source versions of LDAP and Linux vCenter appliances are often configured to allow anonymous binds.

- When an LDAP server allows anonymous base binds, an attacker does not need to know a base object to query a considerable amount of information from the domain. _This can also be leveraged to mount a password spraying attack or read information such as passwords stored in account description fields_. Tools such as windapsearch and ldapsearch can be utilized to enumerate domain information via an anonymous LDAP bind. Information that we obtain from an anonymous LDAP bind can be leveraged to mount a password spraying or AS-REPRoasting attack, read information such as passwords stored in account description fields.
- TOOL - windapsearch
    - https://github.com/ropnop/windapsearch
    - windapsearch is a Python script to help enumerate users, groups and computers from a Windows domain through LDAP queries. By default, Windows Domain Controllers support basic LDAP operations through port 389/tcp. With any valid domain account (regardless of privileges), it is possible to perform LDAP queries against a domain controller for any AD related information.
    - You can always use a tool like ldapsearch to perform custom LDAP queries against a Domain Controller. I found myself running different LDAP commands over and over again, and it was difficult to memorize all the custom LDAP queries. So this tool was born to help automate some of the most useful LDAP queries a pentester would want to perform in an AD environment.

```
# CHECK LDAP NULL AUTHENTICATION AND DOMAIN FUNCTIONAL LEVEL
python3 windapsearch.py --dc-ip 10.129.1.207 -u "" --functionality

# GRAB ALL USERS IN DOMAIN
python3 windapsearch.py --dc-ip 10.129.1.207 -u "" -U
```

- TOOL - LDAP search
    - ldapsearch opens a connection to an LDAP server, binds, and performs a search using specified parameters. The filter should conform to the string representation for search filters as defined in RFC 4515. If not provided, the default filter, (objectClass=*), is used.

```
ldapsearch -h 10.129.1.207 -p 389 -x -b "dc=inlanefreight,dc=local"

```



### Kerberoasting / ASREPRoasting
### NTLM Relaying
### Network traffic poisoning
### Password spraying

### Kerberos delegation abuse
### Domain trust abuse
### Credential theft
### Object control








---

# Terms

## Directory Service
In computing, a directory service or name service maps the names of the network resources to their respective network addresses. It is a shared information infrastructure for locating, managing, administering and organizing everyday items and network resources, which can include volumes, folders, files, printers, users, groups, devices, telephone numbers and other objects.
