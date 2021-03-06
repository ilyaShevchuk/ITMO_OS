#!/bin/bash
src=~/source
lastBackupDate=$(ls ~ | grep -E "^Backup-" | sort -n | tail -1 | sed "s/Backup-//")
lastBackup="$HOME/Backup-${lastBackupDate}"
nowTime=$(date +"%s")
nowDate=$(date +"%Y-%m-%d")
lastBackupTime=$(date -d "$lastBackupDate" +"%s")
timeDiff=$(echo "(${nowTime} - ${lastBackupTime}) / 60 / 60 / 24" | bc)
reportLog=~/.backup-report
if ! [ -d $src ];
then
        echo " Source exception"
        exit 1
fi

if (( $timeDiff > 7 )) || [[ -z "$lastBackupDate" ]];
then
        mkdir "$HOME/Backup-${nowDate}"
        for item in $(ls $src); do
        cp "$src/$item" "$HOME/Backup-$nowDate"
        done
        files=$(ls $src)
        echo -e "Backup (${nowDate}) created:\n${files}" >> $reportLog
else
        changes=""
        for item in $(ls $src); do
                if [[ -f "$lastBackup/$item" ]];
                then
                        srcSize=$(wc -c "$src/${item}" | awk '{print $1}')
                        backSize=$(wc -c "${lastBackup}/${item}" | awk '{print $1}')
                        sizeDiff=$(echo "${srcSize} - ${backSize}" | bc)

                        if (( $sizeDiff != 0 ));
                        then
                        mv "$lastBackup/$item" "$lastBackup/$item.$nowDate"
                        cp "$src/$item" $lastBackup
                        changes="${changes}\n\tFile $item update. Previos version $item.$nowDate"
                        fi
                 else
                        cp "$src/$item" $lastBackup
                        changes="${changes}\n\tFile $item copy"
                 fi
        done

        changes=$(echo $changes | sed 's/^\\n//')
        if [[ ! -z "$changes" ]];
        then
          echo -e "Backup (${lastBackupDate}) updated:\n${changes}" >> $reportLog
        fi
fi