#!/bin/bash

#start this script: ./add_users_in_linux.sh file.txt
#format file.txt "user /home/dir/ password" - one user in line

FILE=$1

cat $FILE | while read LINE
do

        login=$(echo $LINE| awk '{print$1}')
        homedir=$(echo $LINE| awk '{print$2}')
        passwd=$(echo $LINE| awk '{print$3}')

        sudo useradd -d $homedir -m $login -p $passwd -U

        echo 'Success create user ' $login
done
