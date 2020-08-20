# -*- coding: utf-8 -*-
"""
Created on Mon Jul 27 15:34:56 2020

@author: huang
"""

"""
import 语句的另一种形式包括 from 关键字，之后是模块名称，import 关键字和
一个星号，例如 from random import *。
使用这种形式的 import 语句，调用 random模块中的函数时不需要 random.前缀。
但是，使用完整的名称会让代码更可读，所以最好是使用普通形式的 import 语句。
"""

from random  import *
for i in range(5):
    print(randint(1, 10))