# -*- coding: utf-8 -*-
"""
Created on 2020-10-3 23:00
单线程
可选菜单
@author: huang
"""
import os
import re
import requests
import time
import logging
import threading
from lxml import etree

url = 'http://174.127.195.66/bbs/'  # 网站根地址
root = 'D://pydown//sexinsex//'  # 总路径

# 调试定义logging
logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s 【 %(process)d 】 %(processName)s %(message)s"
)


# 加入请求头
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

cookies1 = {
    'cdb3_sid': 'tZrLGr',
    'cdb3_cookietime': '2592000',
    'cdb3_auth': 'eTnmpaKi7e9cx5kkIwAdQx95ej6COhBM5kLklr3rfOrlpTxdB9fedjz%2B%2FaBWTf0HJ2k',
    'cdb3_oldtopics': 'D6906715D',
    'cdb3_fid402': '1600965081'
}

cookies2 = {
    'cdb3_cookietime': '2592000',
    'cdb3_smile': '1D1',
    'cdb3_fid402': '1600965081',
    'cdb3_oldtopics': 'D8762090D6906715D',
    'cdb3_fid322': '1601731530',
    'cdb3_sid': 'ArNDA4',
    'cdb3_auth': '8H%2F%2FRVlCWHMq7UU%2ByLgNBHfgvrWSuUTpamV%2FGw1ndGG%2B1HFkeGx%2F2UfLCI5kv70dKIA'
}



def get_down(text_url, file_name, path, txt_about, fid):
    path1 = path + file_name
    print(path1)
    path2 = path + file_name.split('.')[0] + '.txt'
    print("正在写入txt文件")
    try:
        if not os.path.exists(path2):
            fo = open(path2, "ab+")  # 打开小说文件
            # 以二进制写入章节题目 需要转换为utf-8编码，否则会出现乱码
            fo.write(('\r' + file_name + '\r\n').encode('UTF-8'))
            # 以二进制写入章节内容
            fo.write((txt_about).encode('UTF-8'))
            fo.close()  # 关闭小说文件
        else:
            print("文件已存在")
    except Exception as e:
            print("爬取失败:" + str(e))
    if fid == 402:
        print('正在下载：' + file_name)
        try:
            if not os.path.exists(path1):  # 判断文件是否存在，存在则进行提示
                s = session(text_url, fid)  # 通过requests.get方式获取文件
                if s.status_code == 200:
                    with open(path1, "wb") as f:  # 开始写文件，wb代表写二进制文件
                        f.write(s.content)
                        print("爬取完成")
                return None
            else:
                print("文件已存在")
        except Exception as e:
                print("爬取失败:" + str(e))


def get_txt(title_list, url_list, fid, title_path):
    # item = []
    for i, j in zip(title_list, url_list):
        # 替换title中的特殊字符，避免建立文件出错
        i = re.sub('[:?！!：？【】/]', '', i)
        i = i.replace('/', '')
        path = title_path + i.split(' ')[0] + "//"
        print(path)
        if not os.path.exists(path):
            os.mkdir(path)
        title_url = url + j
        # print(title_url)
        r = session(title_url, fid)
        if r.status_code == 200:
            html1 = etree.HTML(r.text)
            if fid == 402:
                url1 = html1.xpath(
                    r"//dl[@class='t_attachlist']//a/@href")  # 获得文件url
                file_name = html1.xpath(
                    r"//dl[@class='t_attachlist']//a/text()")  # 获得filename
            else:
                url1 = ['0']
                file_name = html1.xpath(r"//h2//text()")
            box_meassage = html1.xpath(
                r"//div[@class='box message']/h1//text()")
            if len(box_meassage) == 1:
                print('您无权进行当前操作!')
            item = html1.xpath(
                r"//div[contains(@id,'postmessage_')]//text()")  # 文章内容
            # 节选部分提取，用""替换br并再将数组转化为字符串
            item = "".join([l.replace("\n", "").replace(
                "\t", "").replace("\r", "") for l in item])
            txt_about = item
            # print(file_name)
            if len(url1) != 0 and len(box_meassage) == 0:
                text_url = url + url1[0]
                file_name = file_name[0]
                file_name = re.sub('[:?！!：？【】]', '', file_name) # 替换title中的特殊字符，避免建立文件出错
                get_down(text_url, file_name, path, txt_about, fid)


def get_sis(title, url_title, fid):  # 获得重要信息
    # fid = url_title.split('=')[1]
    url = 'http://174.127.195.66/bbs/' + url_title   # 原创作者区
    path = root + title + '//'
    fid = int(fid)
    r = session(url, fid)
    if r.status_code == 200:
        if not os.path.exists(path):
            os.mkdir(path)
        html1 = etree.HTML(r.text)
        box_meassage = html1.xpath(
            r"//div[@class='box message']/h1//text()")
        # print(box_meassage)
        if len(box_meassage) != 1:
            pages = html1.xpath(
                r"//div[@class='pages_btns']/div[@class='pages']//a/text()")  # 获得分页pages
            print(pages)
            if pages[len(pages)-1] != '››':
                pages = pages[len(pages)-1]
            else:
                pages = pages[len(pages)-2]
            pages = pages.replace('.', '').replace(' ', '')
            print(title + '总共有 ' + str(pages) + ' 页')
            # print(pages)
            for page in range(1, int(pages) + 1):
            # for page in range(63, 64):
                print('正在下载第 ' + str(page) + ' 页…………')
                url = 'http://174.127.195.66/bbs/forum-' + str(fid) + '-' + str(page)+'.html'
                print(url)
                r = session(url, fid)
                if r.status_code == 200:
                    html2 = etree.HTML(r.text)
                    box_meassage = html2.xpath(
                        r"//div[@class='box message']/h1//text()")
                    if len(box_meassage) != 1:
                        title_list = html2.xpath(
                            r"//tbody[contains(@id,'normalthread_')]//th[@class='hot']//span[contains(@id,'thread_')]//a/text()")  #
                        # print(title_list)
                        url_list = html2.xpath(
                            r"//tbody[contains(@id,'normalthread_')]//th[@class='hot']//span[contains(@id,'thread_')]//a/@href")  #
                        # print(url_list)
                        # print(len(title_list),len(url_list))
                        get_txt(title_list, url_list, fid, path)
                    else:
                        print('您无权进行当前操作!')
                        main()
        else:
            print('您无权进行当前操作!')
            main()


def begin_down(title, url_title):  # 下载选择
    """这里的参数为刚获取的标题和网址还有请求头"""
    print('SIS文学下载'.center(30, '-'))
    print('编号' + '\t\t\t' + ' title')
    for i, j in enumerate(title):
        print(i, '\t\t\t', j)
    inp = int(input('输入下载选项:'))
    print('你选择的是：' + title[inp] + '，fid：' + url_title[inp].split('=')[1])
    get_sis(title[inp], url_title[inp], url_title[inp].split('=')[1])


def get_groups(url):  # 获得重要信息
    """获得每个专栏的网址和标题"""
    r = session(url, '')
    if r.status_code == 200:
        html = etree.HTML(r.text)
        # html = etree.tostring(html)
        # html = etree.fromstring(html)
        url_title = html.xpath(
            r"//div[@id='wrapper']/ul[@id='css8_menu']//a/@href")  # 获得网页分组的url
        title = html.xpath(
            r"//div[@id='wrapper']/ul[@id='css8_menu']//a/text()")  # 获得网页分组的标题
    else:
        print('请求错误!')
    begin_down(title, url_title)  # 把分组标题和分组网址回溯

def session(url, fid):
    if fid == 402:
        cookies = cookies1
    else:
        cookies = cookies2
    # print(cookies)
    session = requests.session()
    session.headers = headers
    requests.utils.add_dict_to_cookiejar(
        session.cookies, cookies)  # 通过cookies跳过登录验证
    r = session.get(url)
    r.encoding = 'gbk'
    return r

def main():
    if not os.path.exists(root):
        os.mkdir(root)
    get_groups(url)



if __name__ == '__main__':
    start1 = time.time()
    main()
    logging.info(f"总花费时间：{time.time()-start1}秒")
