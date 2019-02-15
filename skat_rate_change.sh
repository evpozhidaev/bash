#!/bin/bash

#set -euo pipefail
#trap "echo 'error: Script failed: see failed command above'" ERR

now=$(date +%H)

CONFIG=/etc/dpi/fastdpi.conf

if [[ $now == 21 ]]; then
        RATE="rate 800mbit"
        NEWRATE="rate 350mbit"
else
        RATE="rate 350mbit"
        NEWRATE="rate 800mbit"
fi

sed -i "s/tbf_inbound_class7=${RATE}/tbf_inbound_class7=${NEWRATE}/" $CONFIG && echo "Config changed successfull !"

# Restart skat
service fastdpi restart

# Check starting process and start it if not start
ps auxw | grep fastdpi | grep -v grep > /dev/null

if [ $? != 0 ]; then
service fastdpi start
fi
