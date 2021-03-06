#!/bin/bash

number=1
cmd="+"
echo $$ > .pid
TERM() {
echo "quit"
exit 0
}
usr1(){
cmd="+"
}
usr2(){
cmd="*"
}

trap 'TERM' SIGTERM
trap 'usr1' USR1
trap 'usr2' USR2

while true;
do
        case "$cmd" in
                "+")
                        let number=$number+2
                        ;;
                "*")
                        let number=$number*2
                        ;;
        esac
                echo $number
                sleep 7
done