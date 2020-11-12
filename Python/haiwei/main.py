from selenium import webdriver
from selenium.webdriver.common.keys import Keys
import time, json, os, threading


class HaiWei():
    def __init__(self):
        #默认的链接
        self.url = 'https://www.vmall.com/product/10086726905036.html'
        #默认的按钮 因为那个按钮的类名是会变的,所以只能写child 2 用上一个不会变的a标签来定位按钮
        self.selector = '#pro-operation > a:nth-child(2)'
    def addLogin(self,name):
        '''
        增加一个登录的cookies 就是分别 登录一下账号
        :return:
        '''
        driver = webdriver.Chrome()
        driver.get(self.url)
        # 获取cookie并通过json模块将dict转化成str
        input(f'账号:{name} 请自行登录,登入成功在这里回车:')
        dictCookies = driver.get_cookies()
        jsonCookies = json.dumps(dictCookies)
        # 登录完成后，将cookie保存到本地
        print('获取成功!')
        with open(f'cookies/{name}.json', 'w') as f:
            f.write(jsonCookies)
        driver.close()
    def start(self,name):
        '''
        开始自动多线程抢华为mate40pro手机,因为我 没成功过,所以如果成功了请自己判断
        :return:
        '''
        # 创建浏览器
        driver = webdriver.Chrome()
        # 超时
        driver.set_page_load_timeout(5000)  # 防止页面加载个没完
        #访问一次,不然容易设置不了cookies
        driver.get(self.url)
        # 删除第一次建立连接时的cookie
        driver.delete_all_cookies()
        # 读取登录时存储到本地的cookie
        with open(f'cookies/{name}.json', 'r', encoding='utf-8') as f:
            listCookies = json.loads(f.read())
        for cookie in listCookies:
            #driver.delete_cookie(cookie['name'])
            driver.add_cookie({
                "domain": cookie['domain'],
                "httpOnly": cookie['httpOnly'],
                "name": cookie['name'],
                "path": cookie['path'],
                "secure": cookie['secure'],
                "value": cookie['value']
            })
        driver.get(self.url)
        input(f'账号:{name} 现在请手动的将要买的类型和颜色,尺寸等信息先提前选择好,回车后开始帮你买(多线程的话注意要回车好几次):\n')
        print(f'账号:{name} 现在开始了....目标按钮:{driver.find_element_by_css_selector(self.selector).text}')
        while True:
            try:
                elem = driver.find_element_by_css_selector(self.selector)
                elem.click()
            except:

                break
            time.sleep(0.3)
        # 因为自己都没买到,所以暂时还不知道怎么判断
        input(f'账号:{name} 点击成功!是否抢到资格请自己看!')
        driver.close()
    def setting(self,url,selector):
        '''
        自定义抢购的链接和以及疯狂点击的按钮(css选择器文本输入方法也很简单)
        获取选择器selector文本步骤:
        1.打开你的网站然后在浏览器中找到你需要不断点击的按钮后右键,菜单选择[审核元素\检查]
        2.之后就会出来调试器,就在高亮的元素上右键菜单依次找到 Copy > Copy selector 然后点击就成功复制到文本了
        3.将文本填进去就好了(最好是懂点css的基础,或者自己找规律来改)
        :param url:自定义网址
        :param selector:css选择器文本
        :return:
        '''
        if selector != None and selector != '':
            self.url = url
        if selector!=None and selector!='':
            self.selector=selector
if __name__ == '__main__':
    print('本工具会自动拼命的点购买按钮!没错原理就这么简单!多开几个账号或者一个账号多添加几次(如果觉得线程慢,可以复制整个文件夹,多运行几个')
    print('默认抢的是华为Mate40Pro')
    hw = HaiWei()
    while True:
        key=input('选择功能: 1.增加账号cookies 2.开始多线程抢购 3.自定义产品抢购 注意了别瞎输入,乱输入自动退出!可能会弹一堆的没有注册类请忽略\n')
        if key=='1':
            name = input('输入备注名(字母/数字即可!不要搞重复了切记!可能会弹一堆的没有注册类请忽略):\n')
            hw.addLogin(name)
        elif key=='2':
            print('请手动的将要买的类型和颜色,尺寸等信息先提前选择好,可能会弹一堆的没有注册类请忽略')
            t=[]
            for item in os.listdir(path='cookies'):
                #创建线程
                t.append(threading.Thread(target=hw.start,args=(item.split('.')[0],)))
                #设置主线程关闭时,它也跟着关闭
                t[-1].setDaemon(True)
                #开始运行
                t[-1].start()
            for item in t:
                item.join()
            break

        elif key=='3':
            print('''可能会弹一堆的没有注册类请忽略
            自定义抢购的链接和以及疯狂点击的按钮(css选择器文本输入方法也很简单)
            获取选择器selector文本步骤:
            1.打开你的网站然后在浏览器中找到你需要不断点击的按钮后右键,菜单选择[审核元素\检查]
            2.之后就会出来调试器,就在高亮的元素上右键菜单依次找到 Copy > Copy selector 然后点击就成功复制到文本了
            3.将文本填进去就好了(最好是懂点css的基础,或者自己找规律来改)
            ''')
            url = input('请输入自定义的目标网址():')
            selector = input('请输入自定义按钮的selector文本(如果不填,就只能抢华为mate40系列的):')
            hw.setting(url,selector)
        else:
            print('输入有误或者,你自己要退出的!')
            break

    #'抱歉，没有抢到'
    #'#boxText > p'

