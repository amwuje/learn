# -*- coding: utf-8 -*-
"""
Created on Fri Aug 21 10:50:54 2020

@author: huang
"""

from multiprocessing import Pool
import os
import time


class AA(object):
    def __init__(self):
        print('init')
        self.ab = 3

    def task(self, n):
        self.ab += n
        print("进程(%s), 收到%s, +n=%s" % (os.getpid(), n, self.ab))


if __name__ == '__main__':
    aa = AA()
    p = Pool(4)

    for i in range(65):
        t = p.apply_async(func=aa.task, args=(i,))

    p.close()
    p.join()
    print("done ！  主进程！aa.ab=%s" % aa.ab)
    print("主进程ID  %s " % os.getpid())