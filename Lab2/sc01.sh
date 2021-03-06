arr=$(ps -au user --format pid,command | awk '{print $1":"$2}')
if [[ -z "$arr" ]]
then
        echo "0">sc1.out
else
        echo  "$arr" | wc -l>sc1.out
        echo "$arr" >> sc1.out
fi