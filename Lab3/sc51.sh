#!bin/bash

while true; do
        read line
        if [[ "$line" == "QUIT" ]]; then
                echo "$line" > pipe
                exit 0
        fi
        re='^[0-9]+$'
        if  [[ "$line" != "+" && "$line" != "*" && ! "$line" =~ $re ]]; then
                echo "Error, invalid input"
                echo "$line" > pipe
                exit 1
        fi
        echo "$line" > pipe
done