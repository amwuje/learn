# -*- coding: utf-8 -*-
"""
Created on Wed Aug 19 13:17:00 2020

@author: huang
"""

from Crypto.Hash import MD2
# 原文
txt = "73.25"
# md2加密1亿次
for i in range(100000000):
    txt = MD2.new(txt.encode("utf8")).hexdigest()
print(txt)