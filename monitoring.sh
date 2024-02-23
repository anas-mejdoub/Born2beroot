#!/bin/bash
arch=$(uname -a | awk '{gsub(/PREEMPT_DYNAMIC/, ""); print}')
wall << EOF
#Architecture: $(echo -n $arch)
#CPU physical : $(lscpu | grep Socket | awk '{print $2}')
#vCPU : $(nproc)
#Memory Usage : $(free -m | grep Mem | awk '{printf $3 "/" $2 "MB (%.2f%%)\n" ,($3/$2)*100}')
#Disk Usage: $(df -m --total | grep total | awk '{printf $3 "/%.2fGb (%.2f)\n", $2/1024, ($3/$2)*100}')
#CPU load: $(mpstat 1 1| tail -n 1 |  awk '{printf ("%.2f%%",100-$12)}')
#Last boot: $(who | head -n 1 | awk '{print $3 " " $4}')
#Lvm use: $(lsblk | awk '{print $6 }' |if  grep -q lvm;then echo "yes"; else echo "no";fi)
#Connection TCP : $(netstat | grep ESTABLISHED | wc -l) ESTABLISHED
#User log: $(who | awk '{print $1}' | sort -u| wc -l)
#Network: IP $(hostname -I) ($(ip a | grep ether | awk '{print $2}'))
#Sudo : $(journalctl -q | grep sudo.*COMM | wc -l) cmd
EOF