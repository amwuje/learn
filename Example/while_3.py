# -*- coding: utf-8 -*-
"""
Created on Mon Jul 27 14:19:16 2020

@author: huang
"""


name=''
while True:
    print('yes')
    name=input()
    if name != 'huang': 
        continue
    print('hello,huang! pleset input password')
    password=input()
    if password=='zhang':
        break
print('Acess')