#!/bin/bash
status="false"
for port in $(lsof -i -P -n | grep python); do
        if [ $port = "*:80" ]; then
                status="true"
        fi      
done

if [ $status = "true" ]; then
        echo "Activado"
	badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 250 --max-connections-for-client 3 > /dev/null 2>&1 &
else
        echo "Puerto inactivo"
	python PDirect.py 80 > /dev/null 2>&1 &
	badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 250 --max-connections-for-client 3 > /dev/null 2>&1 &
fi
