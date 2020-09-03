import datetime
import time

#获取当前时间：Thu Nov 03 16:40:00 2016
print(time.strftime("%a %b %d %H:%M:%S %Y", time.localtime()))


#获取当前时间,定义时间格式：2016-11-03 16:40:00
print(datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S'))

#获取年，月，日：2016-11-03
print(datetime.date.today())

#获取当前时间：2016-11-03 16:43:14.550000
print(datetime.datetime.now())

#不加参数是00:00,参数days=1表示一天:1 day, 0:00:00
print(datetime.timedelta(days=1))

#获取昨天日期：2016-11-02
nowtime = datetime.date.today()
oldtime = datetime.timedelta(days=1)
print(nowtime-oldtime)

#获取昨天的精确日期
oldtime = datetime.timedelta(days=1)
print(datetime.datetime.now() - oldtime)
