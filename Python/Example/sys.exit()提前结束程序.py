# -*- coding: utf-8 -*-
"""
Created on Mon Jul 27 15:31:13 2020

@author: huang
"""

"""
用 sys.exit()提前结束程序
要介绍的最后一个控制流概念，是如何终止程序。当程序执行到指令的底部时，
总是会终止。但是，通过调用 sys.exit()函数，可以让程序终止或退出。因为这个函
数在 sys 模块中，所以必须先导入 sys，才能使用它。
"""

import random,sys,os,math

while True:
    print('Type exit to exit.')
    response=input()
    if response=='exit':
        sys.exit()
    print('You typed ' + response + '.')