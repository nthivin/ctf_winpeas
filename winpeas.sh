#!/bin/bash

# Check if two arguments are provided
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <login> <password> <target_ip>"
    exit 1
fi

login=$1
password=$2
target_ip=$3

# Use SSH to log into the remote machine and execute commands
sshpass -p "$password" scp ./winPEASx64.exe "$login"@"$target_ip":C:winPEASx64.exe

sshpass -p "$password" ssh -tt "$login"@"$target_ip" 'winPEASx64.exe --output output.txt'

# SCP to retrieve the output file
sshpass -p "$password" scp "$login"@"$target_ip":output.txt .

# Display the results

echo -e "---- SMB Versions Detected ----"

nmap -p 445 --script smb2-capabilities "$target_ip" | awk '/smb2-capabilities:/,0{
    if (/smb2-capabilities:/) next;  # Skip the smb2-capabilities line

    if ($0 ~ /3:1:1:/) 
        gsub(/3:1:1:/, "\033[31m&\033[0m");  # Red color for version 3.1.1
    else 
        gsub(/([0-9]+:[0-9]+:[0-9]+:)/, "\033[32m&\033[0m");  # Green color for other versions

    print $0;
}'

# Clean up (Optional)
# rm output.txt