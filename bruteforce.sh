#!/bin/bash

# CME #
read -p "Protocol (winrm/ldap/ssh/smb/mssql): " protocol
read -p "Target: " target
read -p "User (Or file path for a dictionnary-based attack): " user
read -p "Password (Or file path for a dictionnary-based attack): " password
crackmapexec "$protocol" "$target" -u "$user" -p "$password" | grep "+"
