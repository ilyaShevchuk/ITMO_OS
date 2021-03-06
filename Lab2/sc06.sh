#!/bin/bash/
maxMem=0
maxPid=0
echo "\n">newfile
for pid in $(ps -A o pid| tail -n +2)
do
        mem=$(grep -s -i "vmrss" /proc/$pid/status | awk '{print $2}')
        if [[ "$mem" != "" ]]
        then
                echo $mem>>newfile
                if [[ $mem -gt $maxMem ]]
                then
                        maxMem=$mem
                        maxPid=$pid
                fi
        fi
done >newfile
echo Pid from proc: $maxPid
echo Pid from top : $(top -bn 1 -o %MEM | sed '8!d' | awk '{printf $1}')
