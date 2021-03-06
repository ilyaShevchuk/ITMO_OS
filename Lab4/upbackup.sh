#!bin/bash

lastBcDate=$(ls ~ | grep -E "^Backup-" | sort -n | tail -1 | sed 's/^Backup-//')
lastBc="$HOME/Backup-${lastBcDate}"
if [[ -z "$lastBcDate" ]];
then
        echo "There is no backup"
        exit 1
fi

if [[ ! -d ~/restore ]];
then
        mkdir ~/restore
else
        rm -r ~/restore
        mkdir ~/restore
fi

for item in $(ls $lastBc | grep -Ev "\.[0-9]{4}-[0-9]{2}-[0-9]{2}$"); do
        cp "${lastBc}/${item}" "$HOME/restore/${item}"
done