# -*- coding: utf-8 -*-
"""
Created on Thu Sep 24 23:58:53 2020

@author: huang
"""

import requests
import os
import time
from lxml import etree

requests.adapters.DEFAULT_RETRIES = 5
s = requests.session()
s.keep_alive = False

all_url = 'https://www.mzitu.com'
# Windows保存地址
path = 'D:/pydown/爬虫/妹子1/'
# 获取每一类的网址
same_url = 'https://www.mzitu.com/page/'  # 也可以指定其它的路径下的图片
# http请求头  User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.70 Safari/537.36
Hostreferer = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.70 Safari/537.36',
    'Referer': 'http://www.mzitu.com'
}
# 此请求头Referer破解盗图链接
Picreferer = {
'User-Agent': 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.70 Safari/537.36',
    'Referer': 'https://i3.mmzztt.com'
}
# 对mzitu主页所有url发起请求，将返回的HTML数据保存，便于解析
index_html = requests.get(all_url, headers=Hostreferer)
#print(index_html.text)
# 获取最大页数
content = etree.HTML(index_html.text)
page_num = content.xpath("//div[@class='nav-links']/a/text()")
max_page = page_num[-2]
print("图片总共页码为："+max_page)
for n in range(1, int(max_page) + 1):
    # 拼接当前url eg：https://www.mzitu.com/page/1
    ul = same_url + str(n)
    print(ul)
    time.sleep(1)
    # 分别对当前类每一页第一层url发起请求，进入第n页
    two_html = requests.get(ul, headers=Hostreferer)
    #print(two_html.text)
    content = etree.HTML(two_html.text)
    urls  = content.xpath("//div[@class='postlist']/ul/li/a/@href")
    names = content.xpath("//div[@class='postlist']/ul/li/a/img/@alt")
    k = 0
    for title in names:
        print(title)
        print("@@@@@@@@@2")
        print(k)
        print(urls[k])
        url_jpg = urls[k]

        k = k + 1
        if k <=2:
            continue
        print("准备抓取：" + str(title))

        # windows不能创建带？的目录，添加判断逻辑
        if (os.path.exists(path + title.strip().replace('?', ''))):
            # print('目录已存在')
            flag = 1
        else:
            os.makedirs(path + title.strip().replace('?', ''))
            flag = 0
        # 切换到上一步创建的目录
        os.chdir(path + title.strip().replace('?', ''))
        # 每个图片对应的url
        print(url_jpg)
        three_html = requests.get(url_jpg, headers=Hostreferer)
        #获取当前页图片的张数
        content = etree.HTML(three_html.text)
        page_num = content.xpath("//div[@class='pagenavi']/a/span/text()")
        print(page_num[-2])
        pic_max = page_num[-2]
        # for i in page_num:
        #     print(i)
        print("总共找到有" + pic_max + "张图片")
        # 遍历每张图片的url
        for num in range(1, int(pic_max) + 1):
            #time.sleep(2)
            # 拼接每张图片的url
            pic = url_jpg + '/' + str(num)
            print(pic)
            #发起请求
            try:
                html = requests.get(pic, headers=Hostreferer, timeout=15)
            except requests.exceptions.RequestException as e:
                print(e)
                continue

            content = etree.HTML(html.text)
            urls_jpg = content.xpath("//div[@class='main-image']/p/a/img/@src")

            time.sleep(2)
            print(urls_jpg[0])
            try:
                html = requests.get(urls_jpg[0], headers=Picreferer, timeout=15)
            except requests.exceptions.RequestException as e:
                print(e)
                continue
            file_name = urls_jpg[0][-9:]
            # 保存图片
            with open(file_name, 'wb') as f:
                f.write(html.content)
                f.flush()
                f.close()
print('下载全部完成')
