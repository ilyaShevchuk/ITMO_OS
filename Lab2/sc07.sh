#!/bin/bash/
for pic in $(ps -Ao pid,command | grep "[0-9]\+" | awk '{print $1 ":" $2}')
do
        pid=$(echo $pic | awk -F ":" '{print $1}')
        cmd=$(echo $pic | awk -F ":" '{print $2}')
        if [[ -r /proc/$pid/io ]]
        then
                mem=$(grep "read_bytes" /proc/$pid/io | awk '{print $2}')
                echo $pid":"$cmd":"$mem
        fi
done > helpFile
sleep 60s
cat helpFile|
while read str
do
        pid=$(echo $str | awk -F ":" '{print $1}')
        cmd=$(echo $str | awk -F ":" '{print $2}')
        mem1=$(echo $str | awk -F ":" '{print $3}')
        if [[ -r /proc/$pid/io ]]
        then
                mem2=$(grep "read_bytes" /proc/$pid/io | awk '{print $2}')
                let diff=$mem2-$mem1
                echo $pid":"$cmd":"$diff
        fi
done | sort -t ":" -nrk3 | head -n3