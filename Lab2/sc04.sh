for PID in $(ps -axo pid)
do
        ppid=$(grep -s "PPid" /proc/"$PID"/status | awk '{print $2}')
        sum_er=$(grep -s "sum_exec_runtime" /proc/"$PID"/sched | awk '{print $3}')
        switches=$(grep -s "nr_switches" /proc/"$PID"/sched | awk '{print $3}')
        b=0
        avg=0
        if [[ "$switches" -ne "$b" ]]
        then
                avg=$(echo "scale=4;$sum_er/$switches" | bc)
        fi
        if [[ $avg != 0 ]]
        then
        echo "ProcessID=$PID : Parent_ProcessId=$ppid : Avg_sleeping_Time=$avg"
        fi
done  | tail -n+2 | sort -t '=' -nk3 > sc4.out