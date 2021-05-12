from selenium import webdriver
import os
import time
import requests

start_url = "https://book.douban.com/subject_search?search_text=python&cat=1001&start=%25s0"

# 控制chrome浏览器
path = os.path.split(os.path.realpath(__file__))[0]
print(path + "\chromedriver\chromedriver.exe")
driver = webdriver.Chrome()
# 输入网址
driver.get(start_url)

# 停一下，等待数据加载完毕
time.sleep(2)
# 获取网页内容Elements
content = driver.page_source
# 结束
driver.quit()
