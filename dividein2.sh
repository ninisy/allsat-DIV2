#!/bin/bash

for file in `ls /home/xiaoqin/SAT/nocluster_para/instance/SAT_dat.k70-24_1_rule_1.cnf`;do
	starttime=`date +'%Y-%m-%d %H:%M:%S'`
	echo $file
	
	#cp $file ./
#dividein2.m修改
	var0=`basename $file`
	#sed -i "5ifilename = '$var0';" dividein2.m
	#sed -i '6d' dividein2.m 
	
#matlab求解
	 #/usr/local/MATLAB/R2017a/bin/matlab -nodesktop -nosplash -r "dividein2;mapping; quit;"
	iscluster=0
	ratio=2
	timeout 300 ./dividein2 $file $iscluster $ratio
	sed -i "s/ 0.*//g" part*.cnf 
	sed -i 's/$/& 0/g' part*.cnf  
	sed -i '1s/ 0/ /g' part*.cnf 
	
#clasp求解
	 timeout 500 ./clasp 0 part1.cnf>solution1.txt
	 timeout 500 ./clasp 0 part2.cnf>solution2.txt
     
result1=`echo |awk 'NR==4{print $2}' solution1.txt`

result2=`echo |awk 'NR==4{print $2}' solution2.txt`
#echo $result1 $result2
r="SATISFIABLE"

zero=0
#记录结果
	endtime=`date +'%Y-%m-%d %H:%M:%S'`
	start_seconds=$(date --date="$starttime" +%s);
	end_seconds=$(date --date="$endtime" +%s);
	name=`basename $file`
	n=`echo |awk 'NR==1{print $1}' n.txt`
	k=`echo |awk 'NR==1{print $2}' n.txt`
if test $result1 = "SATISFIABLE" -a $result2 = "SATISFIABLE";then
#matlab合并
	#/usr/local/MATLAB/R2017a/bin/matlab -nodesktop -nosplash -r "counting; quit;"	
	./counting|| echo $name $n $k "countingwrong" "0" $((end_seconds-start_seconds))"s" >>result_new_sat.csv	
#	./counting
	models=`awk 'NR==1{print $1}' b.txt`
	if test $models -eq $zero; then
		echo $name $n $k "UNKNOWN" "0" $((end_seconds-start_seconds))"s" >>result_new_sat.csv
	else
		echo $name $n $k "SATISFIABLE" $models $((end_seconds-start_seconds))"s" >>result_new_sat.csv
	fi
elif test $result1 = "UNKNOWN" || $result2 = "UNKNOWN";then
	echo $name $n $k "UNKNOWN1" "0" $((end_seconds-start_seconds))"s" >>result_new_sat.csv
else
	echo $name $n $k "UNSATISFIABLE" "-1" $((end_seconds-start_seconds))"s" >>result_new_sat.csv
fi
#删除中间文件
	
	
	
#先手工运行一遍,梳理其中产生文件

done


