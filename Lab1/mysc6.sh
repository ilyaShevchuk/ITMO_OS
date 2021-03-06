touch full.log
awk '{
if ($3 == "(**)")
        print $0
}' /var/log/anaconda/X.log > full.log
awk '{
if ($3 == "(II)")
        print $0
}' /var/log/anaconda/X.log >> full.log
sed -i 's/(\*\*)/Warning/' full.log
sed -i 's/(II)/Information/' full.log