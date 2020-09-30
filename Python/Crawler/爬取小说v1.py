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
    'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9',
    'Accept-Encoding': 'gzip, deflate',
    'Accept-Language': 'zh-CN,zh;q=0.9,en;q=0.8,en-GB;q=0.7,en-US;q=0.6',
    'Cache-Control': 'max-age=0',
    'Connection': 'keep-alive',
    'Host': '174.127.195.66',
    'Upgrade-Insecure-Requests': '1',
    'proxy-authorization': 'Basic bXJ3ZGZOVEQ4TTc5TEN1a0NpZWxkcnFaV3FzPTpleGF4Z3FrS2tkMFRBTXJDeGVvbldnPT0=',
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36 Edg/85.0.564.63'
}  # 加入请求头
cookies ={
    'cdb3_sid':'tZrLGr',
    'cdb3_cookietime':'2592000',
    'cdb3_auth':'eTnmpaKi7e9cx5kkIwAdQx95ej6COhBM5kLklr3rfOrlpTxdB9fedjz%2B%2FaBWTf0HJ2k',
    'cdb3_oldtopics':'D6906715D',
    'cdb3_fid402':'1600965081'
}
session = requests.session()
session.headers = headers
requests.utils.add_dict_to_cookiejar(session.cookies, cookies)

url = 'http://174.127.195.66/bbs/'  # 网站根地址
interval = 0.1  # 爬取小说的间隔时间
root = 'D://pydown//sexinsex//'  # 总路径
if not os.path.exists(root):
    os.mkdir(root)



def get_down(text_url, file_name, path):
    path = path + file_name
    print('正在下载：' + file_name)
    try:
        if not os.path.exists(path):  # 判断图片文件是否存在，存在则进行提示
            s = session.get(text_url)  # 通过requests.get方式获取文件
            if s.status_code == 200:
                with open(path, "wb") as f:  # 开始写文件，wb代表写二进制文件
                    f.write(s.content)
                    print("爬取完成")
            return None
        else:
            print("文件已存在")
    except Exception as e:
            print("爬取失败:" + str(e))


def get_txt(title_list, url_list):
    for i, j in zip(title_list, url_list):
        # 替换title中的特殊字符，避免建立文件出错
        i = re.sub('[:?！!：？【】/]', '', i)
        i = i.replace('/', '')
        path = root + i.split(' ')[0] + "//"
        print(path)
        if not os.path.exists(path):
            os.mkdir(path)
        title_url = url + j
        # print(title_url)
        r = session.get(title_url)
        r.encoding = 'gbk'
        if r.status_code == 200:
            html1 = etree.HTML(r.text)
            url1 = html1.xpath(
                r"//dl[@class='t_attachlist']//a/@href")  # 获得文件url
            file_name = html1.xpath(
                r"//dl[@class='t_attachlist']//a/text()")  # 获得filename
            # print(url1)
            if len(url1) != 0:
                text_url = url + url1[0]
                file_name = file_name[0]
                file_name = re.sub('[:?！!：？【】]', '', file_name) # 替换title中的特殊字符，避免建立文件出错
                get_down(text_url, file_name,path)


def get_groups():  # 获得重要信息
    url = 'http://174.127.195.66/bbs/forumdisplay.php?fid=402'
    path = root
    r = requests.get(url, headers)
    r.encoding = 'gbk'  # 转换编码
    if r.status_code == 200:
        if not os.path.exists(path):
            os.mkdir(path)
        html1 = etree.HTML(r.text)
        pages = html1.xpath(
            r"//div[@class='pages']//a/text()")  # 获得分页pages
        # print(pages)
        pages = pages[len(pages)-1]
        pages = pages.replace('.', '').replace(' ', '')
        # print(pages)
        for page in range(1, int(pages) + 1):
        # for page in range(6, 6):
            print('正在下载第 ' + str(page) + ' 页…………')
            url = 'http://174.127.195.66/bbs/forum-402-' + str(page)+'.html'
            # print(url)
            r = requests.get(url, headers)
            r.encoding = 'gbk' # 转换编码
            if r.status_code == 200:
                html2 = etree.HTML(r.text)
                title_list = html2.xpath(
                    r"//tbody[contains(@id,'normalthread_')]//th[@class='hot']//span[contains(@id,'thread_')]//a/text()")  #
                # print(title_list)
                url_list = html2.xpath(
                    r"//tbody[contains(@id,'normalthread_')]//th[@class='hot']//span[contains(@id,'thread_')]//a/@href")  #
                # print(url_list)
                print(len(title_list),len(url_list))
            get_txt(title_list, url_list)

def main():
    get_groups()


if __name__ == '__main__':
    start1 = time.time()
    main()
    logging.info(f"总花费时间：{time.time()-start1}秒")
