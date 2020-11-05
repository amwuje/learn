#coding:utf-8

 
import re
 
f1=file('shen.txt','r')
data1=f1.readlines()
# print data1
f1.close()
results = []
 
for line in data1:
    data2=line.split()
    # print data2[0]
    m = re.findall(r"[0-9]:", data2[0])
    if m:
        results.append(line)
 
    # for i in data2[0]:
        # data3=i.split(":")
        # print data3
        # if data3>=0 and data3<=50000:
        #     results.append(line)
 
 
        # if i=='1':
        #     results.append(line)
 
f2=file('deal.txt','w')
f2.writelines(results)
f2.close()
 
# 替换掉所有的逗号，
f4=open('deal.txt','r')
data3=f4.read()
f4=data3.replace(',',' ')
f5=file('deal.txt','w')
f5.write(f4)
f5.close()
 
# 替换掉所有的冒号
f6=open('deal.txt','r')
data4=f6.read()
f6=data4.replace(':',' ')
f7=file('deal.txt','w')
f7.write(f6)
f7.close()