# allsat-DIV2
## This is an allsat solver based on divide and conquer. 
### 1.Platform
      LINUX 16.04, MATLAB 2017a
### 2.two ways to use this solver.
#### 2.1 First--edit the file 'dividein2.sh'. One example is as follow:
      Located to line 3:change the filename to yours. after Athe run is complete, you can get a file 'result.csv', which includs the reuslt. 
      Such as: uf20-01.cnf 20 91 SATISFIABLE 8 28s(8 means the number of solutions)
#### 2.2 Step by step
      #timeout 300 dividein2 filename iscluster ratio 
      //'iscluster = 1' means will reorder the clauses, 'iscluster = 1' means will not reorder the clauses. ratio means divide ratio, which can be 1 to n(n is not bigger than the number of clauses).
      #timeout 500 ./clasp 0 part1.cnf
      #timeout 500 ./clasp 0 part2.cnf
      #./counting
      //The final step will output the number of solutions

##### If you have any question or advice, please contact me by email：201621220145@std.uestc.edu.cn

Edit by ninisy Ren.
      




