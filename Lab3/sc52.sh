#!/bin/bash
cmd="+"
number=1
(tail -f pipe) |
while true;
do
        read line
        case "$line" in
                "*")
                        cmd="$line"
                        ;;
                "+")
                        cmd="$line"
                        ;;
                "QUIT")
                        pid=$$
                        echo "Program end"
                        kill $(ps --ppid $pid | egrep 'tail$'|awk '{print $1}')
                        exit 0
                        ;;
                [0-9]*)
                        case $cmd in
                                "+")
                                        number=$(($number+$line))
                                        echo $number
                                        ;;
                                "*")
                                        number=$(($number*$line))
                                        echo $number
                                        ;;
                        esac
                        ;;
                *)
                        killall tail
                        exit 1
                        ;;
        esac
done