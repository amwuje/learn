#!/bin/bash
#쳲���������,�ֳƻƽ�ָ����У�ָ��������һ�����У�0��1��1��2��3��5��8��13��21����������ÿһ���ǰ����ĺͣ��������е�������Ϊ0��1
echo "How many numbers do you want of Fibonacci series ?" 
  read total 
  x=0 
  y=1 
  i=2 
  echo "Fibonacci Series up to $total terms :: " 
  echo "$x" 
  echo "$y" 
  while [ $i -lt $total ] 
  do 
      i=`expr $i + 1 ` 
      z=`expr $x + $y ` 
      echo "$z" 
      x=$y 
      y=$z 
  done
