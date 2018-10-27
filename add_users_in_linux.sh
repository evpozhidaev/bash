#!/bin/bash

#start this script: ./add_users_in_linux.sh file.txt
#format file.txt "user /home/dir/ password" - one user in line

FILE=$1

if [ -f "$FILE" ]
then
  
  # Построчно читаем файл
  cat $FILE | while read LINE; do
    
    ARGUMENT_COUNT=$(echo $LINE| wc -w)
    
    #echo $ARGUMENT_COUNT

    if [ $ARGUMENT_COUNT != 0 ]; then
    
      login=$(echo $LINE| awk '{print$1}')
      homedir=$(echo $LINE| awk '{print$2}')
      passwd=$(echo $LINE| awk '{print$3}')

      echo $login
      #sudo useradd -d $homedir -m $login -p $passwd -U
      #  echo 'Success create user ' $login
    else
      
      if [ $ARGUMENT_COUNT = 0 ]; then
        echo "Must have minimum 1 argument in file $FILE"
        exit 0;
      else
        echo "Argument at 1 line must be less then 8 in $FILE"
        exit 0;
      fi
 
    fi

  done

else

  echo "Wrong argument: $FILE - it is not file"

fi
