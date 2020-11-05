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
url = 'https://www.mnmulu.com/'  # 网站根地址
interval = 0.1  # 爬取图片的间隔时间
root = 'D://pydown//mnmulu//'  # 总路径
if not os.path.exists(root):
    os.mkdir(root)


def LaunchViewer(Folder):
    try:
        os.startfile(Folder)
    except AttributeError:
        subprocess.call(['open', Folder])

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

def get_img(url_list,path):
    for i in url_list:
        file_name = i.split('/')[-2]
        file_name = path + file_name + ".jpg"
        print(file_name)
        url2 = url + i # 合成图片所在html页面地址
        print(url2)
        r = requests.get(url2, headers)
        r.encoding = 'utf-8'
        if r.status_code != 404:
            html2 = etree.HTML(r.text)
            img_src = html2.xpath(
                r"//div[@class='photo-box']//img/@src")  # 获得图片地址
            img_src = img_src[0]
            get_down(img_src, file_name)
            # time.sleep(interval)


# https: // www.mnmulu.com/photos/zhaoliying_list/
def get_groups():  # 获得重要信息
    inp = input('输入明星名字全拼:') 
    inp1 = inp + "_list/"
    url1 = url + "photos/" + inp1
    path = root + inp + "//"
    # print(url1)
    r = requests.get(url1)
    r.encoding = 'utf-8'  # 转换编码
    if r.status_code != 404:
        if not os.path.exists(path):
            os.mkdir(path)
        html1 = etree.HTML(r.text)
        pages = html1.xpath(
            r"//nav[@class='pagination mb mt']//a/@href")  # 获得分页pages
        # pages = pages[len(pages)-2]
        # print(pages[-1])
        pages = re.findall(r"\d+\.?\d*", pages[-1])
        # pages = str(pages[0])
        # print(pages)
        for page in range(1, int(pages[0]) + 1):
        # for page in range(0, 1):
            # https://www.mnmulu.com/photos/zhaoliying_list/?page=2
            url2 = url1 + "?page=" + str(page)
            print(url2)
            r = requests.get(url2, headers)
            r.encoding = 'utf-8' # 转换编码
            if r.status_code != 404:
                html2 = etree.HTML(r.text)
                url_list = html2.xpath(
                    r"//div[@class='photo-list row']//a/@href")  # 获取photo-list
                print(url_list)
                get_img(url_list,path)
        LaunchViewer(path)
    else:
        print('重新输入')
        get_groups()

def main():
    get_groups()


if __name__ == '__main__':
    start1 = time.time()
    main()
    logging.info(f"总花费时间：{time.time()-start1}秒")
