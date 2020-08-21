#!/bin/bash
#斐波那契数列,又称黄金分割数列，指的是这样一个数列：0、1、1、2、3、5、8、13、21……，它的每一项都是前两项的和，定义数列的首两项为0、1
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
