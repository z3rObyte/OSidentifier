#!/bin/bash

# ctrl_c
trap ctrl_c INT
function ctrl_c(){
	echo -e "\n[+] Saliendo..."
	exit 1
}

# check args
if [ $# != '1' ]; then
	echo -e "\n[!] Usage: $0 HOST"
	exit 1
fi

# check connection TTL value parse
ping -c 1 $1 &>/dev/null
if [ $? -ne 0 ]; then
	echo -e "\n[!] Host unreachable. Check your Internet connection."
	exit 1
fi

ttl=$(ping -c 1 $1 | awk '{print $2}' FS="ttl=" | awk '{print $1}' | xargs)

# Guess OS by its IP
if [ $ttl -gt 0 ] && [ $ttl -lt 65 ]; then
	echo -e "$1 -> Linux"

elif [ $ttl -gt 64 ] && [ $ttl -lt 129 ]; then
	echo -e "$1 -> Windows"
	
else
    echo -e "$1 -> Unknown OS"
fi
