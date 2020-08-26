# -*- coding: utf-8 -*-

import logging
import os
import sys
import time

logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s 【 %(process)d 】 %(processName)s %(message)s"
)

start = time.time()
# 打印当前目录
print("当前工作目录 : %s" % os.getcwd())
# 获取脚本所在目录
path = os.path.split(os.path.realpath(__file__))[0]  
# 被初始执行的脚本的所在目录
print('被初始执行的脚本的所在目录' + sys.path[0])
# 这个脚本的目录
print('这个脚本的目录' + os.path.split(os.path.realpath(__file__))[0])
# 这个脚本的绝对路径
print('这个脚本的绝对路径' + os.path.realpath(__file__))
# 获取脚本所在目录下面的所有文件
print(os.listdir(path)) 
print("当前时间的时间戳：%f" % time.time())
print("当前时间："+ time.ctime())
logging.info(f"总花费时间：{time.time()-start}秒")
