#!/bin/bash

for file in `ls ./instance/uf20-01.cnf`;do
	starttime=`date +'%Y-%m-%d %H:%M:%S'`
	echo $file

	var0=`basename $file`
	
	iscluster=0
	ratio=2
	timeout 300 ./dividein2 $file $iscluster $ratio
	sed -i "s/ 0.*//g" part*.cnf 
	sed -i 's/$/& 0/g' part*.cnf  
	sed -i '1s/ 0/ /g' part*.cnf 
	

	 timeout 500 ./clasp 0 part1.cnf>solution1.txt
	 timeout 500 ./clasp 0 part2.cnf>solution2.txt
     
result1=`echo |awk 'NR==4{print $2}' solution1.txt`

result2=`echo |awk 'NR==4{print $2}' solution2.txt`

r="SATISFIABLE"

zero=0

	endtime=`date +'%Y-%m-%d %H:%M:%S'`
	start_seconds=$(date --date="$starttime" +%s);
	end_seconds=$(date --date="$endtime" +%s);
	name=`basename $file`
	n=`echo |awk 'NR==1{print $1}' n.txt`
	k=`echo |awk 'NR==1{print $2}' n.txt`
if test $result1 = "SATISFIABLE" -a $result2 = "SATISFIABLE";then

	./counting|| echo $name $n $k "countingwrong" "0" $((end_seconds-start_seconds))"s" >>result.csv	

	models=`awk 'NR==1{print $1}' b.txt`
	if test $models -eq $zero; then
		echo $name $n $k "UNKNOWN" "0" $((end_seconds-start_seconds))"s" >>result.csv
	else
		echo $name $n $k "SATISFIABLE" $models $((end_seconds-start_seconds))"s" >>result.csv
	fi
elif test $result1 = "UNKNOWN" || $result2 = "UNKNOWN";then
	echo $name $n $k "UNKNOWN1" "0" $((end_seconds-start_seconds))"s" >>result.csv
else
	echo $name $n $k "UNSATISFIABLE" "-1" $((end_seconds-start_seconds))"s" >>result.csv
fi

done


