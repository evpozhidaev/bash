#!/bin/bash
# Script checks the date of paid till
if [ "$1" == "" ]; then
cat << EOF
        This is script for monitoring registration date for domain
        Usage: $(basename $0) filename - filename containt list of domains
EOF
exit
fi

FILE="$1"

if [ -e $FILE ] && [ ! -z $FILE ]; then
        while read DOMAIN; do
                PAIDTILL=$(whois $DOMAIN | grep 'paid-till')
                if [ -z "$PAIDTILL" ]; then
                        echo "Information unavalible for this domain: $DOMAIN"
                else
                        PAIDTILL=${PAIDTILL#*:}
                        NOW=$(date "+%Y-%m-%d %H:%M:%S")
                        DAYS_LEFT=$(( ($(date -d "$PAIDTILL" +%s) - $(date -d "$NOW" +%s) ) / 86400 ))
                        if [ $DAYS_LEFT -lt 30 ]; then
                                curl -s -X POST http://IP/script.php -d chatid=CHATID -d text="Регистрация домена: $DOMAIN закончится через $DAYS_LEFT дней"
                        fi
                fi
        done <"$FILE"
fi
