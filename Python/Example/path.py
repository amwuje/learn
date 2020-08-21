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
path = os.path.split(os.path.realpath(__file__))[0]  # 获取脚本所在目录
print(sys.path[0])  # 被初始执行的脚本的所在目录
print(os.path.split(os.path.realpath(__file__))[0])  # 这个脚本的目录
print(os.path.realpath(__file__))  # 这个脚本的绝对路径
# print(os.listdir(path)) # 获取脚本所在目录下面的所有文件
print("当前时间的时间戳：%f" % time.time())
print("当前时间："+ time.ctime())
logging.info(f"总花费时间：{time.time()-start}秒")
