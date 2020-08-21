# coding:utf-8

"""
Created on Thu Aug 21 15:57:00 2020
20200821 基本功能
@author: huang
"""
from bs4 import BeautifulSoup  # 引用BeautifulSoup库
import requests  # 引用requests
import os  # os

root = 'D://pydown//img//'  # 配置存储路径

def (aa,bb):
    for page in range(1, 5):  # 配置爬取页码，我这边配置的是5个人的图片
    for p in range(1, 20):  # 配置爬取每个人多少张的参数，我这边配置的是每个人20张
        url = 'http://www.win4000.com/meinv'+str(page)+'_'+str(p)+'.html'
        r = requests.get(url)  # 使用requests中的get方法获取整个网页
        r.encoding = 'utf-8'  # 设定网页所使用的编码方式，错误的编码方式会导致乱码
        if r.status_code != 404:  # 判断生成后的链接是不是能访问，只有能访问才能爬取下载
            demo = r.text  # 将爬取后的对象通过text方法提取出所有的html
            # 使用BeautifulSoup库进行整合，第二个参数使用lxml一样的，lxml兼容性好较好，速度较快
            soup = BeautifulSoup(demo, "html.parser")
            # 选取整合后我们需要的部分内容，选取后的数据为list数组
            text = soup.find_all('img', class_='pic-large')
            for img in text:
                # 取出img标签中data-original中的值
                imagr_url = img.get('data-original')
                # 取出图片地址中文件及文件扩展名与本地存储路径进行拼接
                file_name = root + imagr_url.split('/')[-1]
                try:
                    if not os.path.exists(root):  # 判断文件夹是否存在，不存在则创建文件夹
                        os.mkdir(root)
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

def (aa,bb)



if __name__ == '__main__':
    getUrl = getUrl()
    getUrl
