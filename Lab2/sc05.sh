#!/bin/bash
> sc5.out
ppid=-1
sum=0
count=0
while read line
do
 curppid=$(echo "$line" | awk -F "[=:]" '{print $4}')
 curart=$(echo "$line" | awk -F "[=:]" '{print $6}')
 if (( $ppid != $curppid && $ppid != -1 )) ; then
  avgart=$(echo "scale=7;$sum/$count" | bc)
  echo "Average_Sleeping_of_ParentID=$ppid is $avgart" >> sc5.out
  count=0
  sum=0
 fi
 ppid=$curppid
 sum=$(echo "scale=7;$sum+$curart" | bc)
 ((count++))
 echo "$line" >> sc5.out
done < sc5.in
echo "Average_Sleeping_of_ParentID=$ppid is $(echo "scale=7;$sum/$count" | bc)" >> sc5.out