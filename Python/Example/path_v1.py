#!/usr/bin/python
# -*- coding: UTF-8 -*-

import os
import sys

# 切换到 "C:\Users\huang\Learn\" 目录
os.chdir('C://Users//huang//Learn//')

# 打印当前目录
print ("当前工作目录 : %s" % os.getcwd())

# 打开 "/tmp"
# fd = os.open("C://Users//huang//Learn//", os.O_RDONLY)

# 使用 os.fchdir() 方法修改目录
# os.fchdir(fd)

# 打印当前目录
print ("当前工作目录 : %s" % os.getcwd())

# 关闭文件
# os.close(fd)
