import requests
from lxml import etree
import os

# 设置保存路径
path = 'D:\pydown\picture_1\ '
# 如果目录不存在，则新建
if not os.path.exists(path):
    os.makedirs(path)
# 目标url
url = "http://pic.netbian.com/4kmeinv/index.html"
# 伪装请求头  防止被反爬
headers = {
    "user-agent":"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36",
    "Referer": "http://pic.netbian.com/4kmeinv/index.html"
}

# 发送请求  获取响应
response = requests.get(url, headers=headers)
# 打印网页源代码来看  乱码   重新设置编码解决编码问题
# 内容正常显示  便于之后提取数据
response.encoding = 'GBK'
html = etree.HTML(response.text)
# xpath定位提取想要的数据  得到图片链接和名称
img_src = html.xpath('//ul[@class="clearfix"]/li/a/img/@src')
# 列表推导式   得到真正的图片url
img_src = ['http://pic.netbian.com' + x for x in img_src]
img_alt = html.xpath('//ul[@class="clearfix"]/li/a/img/@alt')

for src, name in zip(img_src, img_alt):
    img_content = requests.get(src, headers=headers).content
    img_name = name + '.jpg'
    with open(path + img_name, 'wb') as f:   # 图片保存到本地
    	print(f"正在为您下载图片：{img_name}")
        f.write(img_content)