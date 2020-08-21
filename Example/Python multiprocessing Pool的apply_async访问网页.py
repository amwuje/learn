# -*- coding: utf-8 -*-
"""
Created on Fri Aug 21 10:53:25 2020

@author: huang
"""


import logging
import multiprocessing
import os
import re
import time
from urllib.request import urlopen

logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s 【 %(process)d 】 %(processName)s %(message)s"
)

url_lst = [
    'http://www.baidu.com',
    'http://www.sohu.com',
    'http://www.sogou.com',
    'http://www.4399.com',
    'http://www.cnblogs.com',
]


def get_url (url):
    response = urlopen(url)
    ret = re.search('www\.(.*?)\.com', url)
    logging.info('%s finished' % ret.group(1))
    return (ret.group(1), response.read())


def call (content):
    url, con = content
    with open(url + '.html', 'wb')as f:
        f.write(con)


def main (ctx):
    start = time.time()
    p = ctx.Pool(5)
    for url in url_lst:
        p.apply_async(get_url, args=(url,), callback=call)
    p.close()
    p.join()
    logging.info(f"总花费时间：{time.time()-start}秒")


if __name__ == '__main__':
    # windows 启动方式
    multiprocessing.set_start_method('spawn',True)
    # 获取上下文
    ctx = multiprocessing.get_context('spawn')
    # 检查这是否是冻结的可执行文件中的伪分支进程。
    ctx.freeze_support()
    main(ctx)

