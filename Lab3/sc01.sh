#!/bin/bash/

data1=$(date '+%F_%T')
mkdir $HOME/test && { echo "catalog test was created successfully" > $HOME/report ; touch $HOME/test/$data1 ; }
ping www.net_nikogo.ru || echo $data1 random text >> $HOME/report