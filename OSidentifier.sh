#!/bin/bash

# ctrl_c
trap ctrl_c INT
function ctrl_c(){
echo -e "\n[+] Saliendo..."
exit 0

}

# validación de argumentos

if [ $# != '1' ];then

echo -e "\n[!] Uso: $0 ip. Ejemplo: $0 8.8.8.8\n"
exit 1

fi

# captura del ttl


ttl=$(ping -c 1 $1 | awk '{print $2}' FS="ttl" | sed 's/=//' | awk '{print $1}')


# estructura de condicionales para averiguar el sistema operativo

if [ $ttl -gt 0 ]; then

	if [ $ttl -lt 65 ]; then

		echo -e "\n$1 -> Linux\n"
	fi
fi

if [ $ttl -gt 64 ]; then

	if [ $ttl -lt 129 ];then
		echo -e "\n$1 -> Windows\n"
	fi
fi



if [ $ttl -gt 128 ]; then

    echo -e "\n$1 -> Unknown OS\n"
fi

# fin del script
