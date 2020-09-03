import datetime

# 【打印当前，年，月，日】
print(datetime.date.today())

# 【打印当前时间，精确到微秒】
current_time = datetime.datetime.now()
print(current_time)

# 【转成time.struct_time格式时间】
current_time = datetime.datetime.now()
print(current_time.timetuple())

# 【加十天】
print(datetime.datetime.now() + datetime.timedelta(days=10))
# 【减十天】
print(datetime.datetime.now() + datetime.timedelta(days=-10))
# 【减十个小时】
print(datetime.datetime.now() + datetime.timedelta(hours=-10))
# 【加120s】
print(datetime.datetime.now() + datetime.timedelta(seconds=120))

# 【替换成指定的时间】
cr_time = datetime.datetime.now()
print(cr_time.replace(2014, 9, 12))
# 结果：2014-09-12 17: 28: 17.522893

# 【格式化输出】
print(datetime.datetime.strptime("21/11/06 16:30", "%d/%m/%y %H:%M"))

# 【替换成指定时间后，类型是 < class 'datetime.datetime' >】
current_time = datetime.datetime.now()
time_obj = current_time.replace(2015, 5)
print(time_obj, type(time_obj))
# 结果：2015-05-27 17: 34: 13.350245 < class 'datetime.datetime' >

# 【对比时间大小，取指定时间范围使用】
current_time = datetime.datetime.now()
time_obj = current_time.replace(2015, 5)
print(current_time > time_obj)
