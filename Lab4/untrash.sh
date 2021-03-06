trashDir=~/trash
trashLog=~/trash.log

restore() {
   fPath=$1
   trashName=$2
   toDir=$(echo "$fPath" | awk 'BEGIN{FS="/";OFS="/"}; {$NF=""; print $0}')
   fName=$(echo "$fPath" | awk 'BEGIN{FS="/"}; {print $NF}')
   newFName=""


   if [[ ! -d $toDir ]];
   then
        echo "Directory ${toDir} does't exists. \"${fName}\" will be restored in home directory"
        if [[ -f "${HOME}/${fName}" ]];
        then
        read -p "File \"~/${fName}\" already exists. Write new name: " newFName
        ln "${trashDir}/${trashName}" "${HOME}/${newFName}"
        rm "${trashDir}/${trashName}"
        else
        ln "${trashDir}/${trashName}" "${HOME}/${fName}"
        rm "${trashDir}/${trashName}"
        fi
   else
        if [[ -f "${fPath}" ]];
        then
        read -p "File \"${fPath}\" already exists. New name:" newFName
        ln "${trashDir}/${trashName}" "${toDir}/${newFName}"
        rm "${trashDir}/${trashName}"
        else
        ln "${trashDir}/${trashName}" "${fPath}"
        rm "${trashDir}/${trashName}"
        fi
   fi

}

  if [[ $# != 1 ]];
  then
      echo "Arguments exception"
      exit 1
  fi

  if [[ ! -d $trashDir ]];
  then
      echo "Trash directory exception"
      exit 1
  fi

  if [[ ! -f $trashLog ]];
  then
      echo "Trash log exception"
      exit 1
  fi

  if [[ -z $(grep "$1" $trashLog) ]];
  then
      echo "File $1 doesnt exist "
      exit 1
  fi

   for tr in $(grep "$1 " $trashLog | awk '{print $2}');
   do
        fPath=$(grep  $tr   $trashLog | awk '{print $1}')
        read -p "Restore ${fPath}? [y/n] " ans
        case  "$ans" in
        "y")
                restore "$fPath" $tr
                sed "/${tr}/d" $trashLog > ~/.trash.log2 && mv ~/.trash.log2 $trashLog
                ;;
        "n")
                continue
                ;;
        *)
                echo "wrong command"
                ;;
                esac

done