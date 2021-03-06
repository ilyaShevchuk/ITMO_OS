#!/bin/bash
trashLog=~/trash.log
trashDir=~/trash
file="$PWD/$1"
lname=$(date +"%H-%M-%S_%F")
if [[ $# != 1 ]];
then
        echo "Invalid Arguments"
        exit 1
fi

if [[ ! -f $file ]];
then
        echo "Wrong file name"
        exit 1
fi

if [[ ! -d $trashDir ]];
then
        mkdir $trashDir
        touch $trashLog
fi

ln "$file" "$trashDir/$lname"
echo "$file $lname" >> $trashLog
rm "$file"