# -*- coding: utf-8 -*-
"""
Created on Fri Jul 31 13:14:55 2020

@author: huang
"""


def fn1():
    print('hello')
    
# fn1()
fn2=fn1
fn2()

# 回调
def fm(x,f):    #f=f6
    n=f(x)
    print(n)
    
def f6(m):
    m=m+1
    return m*m
fm(11,f6)
