import time
# 【返回时间戳】
print(time.time())

# 【返回当前时间】
print(time.ctime())

# 【返回一天前的时间】
print(time.ctime(time.time()-86400))

# 【函数返回time.struct_time类型的对象】
time_obj = time.gmtime()
print(time_obj)
# 结果：time.struct_time(tm_year=2016, tm_mon=7, tm_mday=27, tm_hour=8, tm_min=52, tm_sec=26, tm_wday=2, tm_yday=209, tm_isdst=0)
# 格式化输出：
print(time_obj.tm_year, time_obj.tm_mon, time_obj.tm_mday)

print("{year}-{month}".format(year=time_obj.tm_year, month=time_obj.tm_mon))

# 【以time.struct_time类型，打印本地时间】
print(time.localtime())

# 【转换成时间戳】
time_obj = time.gmtime()
print(time.mktime(time_obj))

# 【延时2秒】
time.sleep(2)

# 【打印UTC，世界标准时间，北京时区是东八区，领先UTC八个小时】
print(time.strftime("%Y-%m-%d %H:%M:%S", time.gmtime()))

# 【本地时间】
print(time.strftime("%Y-%m-%d %H:%M:%S", time.localtime()))

# 【把time.struct_time类型时间，转换成时间戳】
tm = time.strptime("2016-05-6 15:06:33", "%Y-%m-%d %H:%M:%S")
print(tm)
print(time.mktime(tm))
