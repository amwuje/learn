import os
import re
import requests
import time
import logging
import threading
from lxml import etree


headers = {
    "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36"
}  # 加入请求头
url = 'http://www.win4000.com/meinv207397.html'
r = requests.get(url, headers)
r.encoding = 'utf-8'
if r.status_code != 404:
    html = etree.HTML(r.text)
    pages = html.xpath(
        r"//div[@class='ptitle']//em/text()")  # 获得分页pages
    pages = pages[0]
    print(int(pages))
    url1 = url.replace('.html', '_')
    # print(url)
    for page in range(1, int(pages) + 1):
        url2 = url1 + str(page) + '.html'
        print(url2)
        r = requests.get(url2, headers)
        r.encoding = 'utf-8'
        if r.status_code != 404:
            html1 = etree.HTML(r.text)
            src = html1.xpath(
                r"//div[@class='paper-down']//a/@href")
            # src = html1.xpath(
            #     r"//div[@class='col-main']/div[@class='main-wrap']/div[@class='pic-meinv']/a/img/@src")  # 获得图片地址
            print(src)
