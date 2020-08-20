# -*- coding: utf-8 -*-
"""
Created on Mon Jul 27 14:53:21 2020

@author: huang
"""


total=0
for num in range(1,101):
    total=total+num
print('1+2+3+...+100 =',total)

i=0
total=0
while i < 1001:
    total=total+i
    i=i+1

print('1+2+3+...+1000 =',total)