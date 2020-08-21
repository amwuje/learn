# -*- coding: utf-8 -*-
"""
Created on Wed Aug 19 14:09:23 2020

@author: huang
"""


import hashlib
# 原文
txt = "李兆廷"
# md4加密1亿次
for i in range(100000000):
    txt = hashlib.new('md4', txt.encode("utf8")).hexdigest()
print(txt)