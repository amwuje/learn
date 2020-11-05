# -*- coding: utf-8 -*-
"""
Created on 2020-09-11 23:00
单线程
@author: huang
"""
import os
import re
import requests
import time
import logging
import threading
from lxml import etree

# 调试定义logging
logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s 【 %(process)d 】 %(processName)s %(message)s"
)
headers = {
    "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36"
}  # 加入请求头
url = 'http://www.win4000.com/'  # 网站根地址
interval = 0.1  # 爬取图片的间隔时间
root = 'D://pydown//win4000//'  # 总路径
if not os.path.exists(root):
    os.mkdir(root)


def get_down(imagr_url, file_name):
    try:
        if not os.path.exists(file_name):  # 判断图片文件是否存在，存在则进行提示
            s = requests.get(imagr_url)  # 通过requests.get方式获取文件
            # 使用with语句可以不用自己手动关闭已经打开的文件流
            with open(file_name, "wb") as f:  # 开始写文件，wb代表写二进制文件
                f.write(s.content)
                print("爬取完成")
        else:
            print("文件已存在")
    except Exception as e:
            print("爬取失败:" + str(e))   

def get_img(inp,title_list, url_list):
    for title, url in zip(title_list, url_list):
        path = root + inp + "//" + title + "//"
        print(path)
        if not os.path.exists(path):
            os.mkdir(path)
        r = requests.get(url, headers)
        r.encoding = 'utf-8' 
        if r.status_code != 404:
            html1 = etree.HTML(r.text)
            pages = html1.xpath(
                r"//div[@class='ptitle']//em/text()")  # 获得分页pages
            pages = pages[0]
            # print(int(pages))
            url1 = url.replace('.html', '_')
            # print(url)
            for page in range(1,int(pages) + 1):
                url2 = url1 + str(page) +'.html' #合成图片所在html页面地址
                # print(url2)
                r = requests.get(url2, headers)
                r.encoding = 'utf-8'
                if r.status_code != 404:
                    html2 = etree.HTML(r.text)
                    src = html2.xpath(
                        r"//div[@class='paper-down']//a/@href") # 获得图片地址
                    # src = src[0]
                    imagr_url = src[0].replace('?down', '')
                    file_name = path + imagr_url.split('/')[-1]
                    get_down(imagr_url, file_name)
                    # time.sleep(interval)


def get_groups():  # 获得重要信息
    inp = input('输入明星名字全拼:')
    url = 'http://www.win4000.com/mt/' + inp + '.html'
    path = root + inp + "//"
    r = requests.get(url, headers)
    r.encoding = 'utf-8'  # 转换编码
    if r.status_code != 404:
        if not os.path.exists(path):
            os.mkdir(path)
        html1 = etree.HTML(r.text)
        pages = html1.xpath(
            r"//div[@class='pages']//a/text()")  # 获得分页pages
        pages = pages[len(pages)-2]
        # print(pages)
        for page in range(1, int(pages) + 1):
        # for page in range(0, 1):
            url = 'http://www.win4000.com/mt/' + \
                inp + '_' +str(page)+'.html'
            print(url)
            r = requests.get(url, headers)
            r.encoding = 'utf-8' # 转换编码
            if r.status_code != 404:
                html2 = etree.HTML(r.text)
                title_list = html2.xpath(
                    r"//div[@class='w1180 clearfix']//div[@class='Left_bar']//div[@class='tab_box']//ul[@class='clearfix']/li//a/img/@title")  # 获得分页pages
                print(title_list)
                url_list = html2.xpath(
                    r"//div[@class='w1180 clearfix']//div[@class='Left_bar']//div[@class='tab_box']//ul[@class='clearfix']/li//a/@href")  # 获得分页pages
                print(url_list)
            get_img(inp,title_list, url_list)
    else:
        print('重新输入')
        get_groups()

def main():
    get_groups()


if __name__ == '__main__':
    start1 = time.time()
    main()
    logging.info(f"总花费时间：{time.time()-start1}秒")
