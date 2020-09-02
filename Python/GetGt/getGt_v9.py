# -*- coding: utf-8 -*-
# =============================================================================
#
# Created on Fri Jul 31 13:49:20 2020
# 20200803 分析原始GTlog，提取GT、ES组成dict
# 20200804 添加写入EXCEL功能
# 20200821 路径更加灵活
# 20200826 优化脚本
# 20200829 数据存入mysql
# @author: huang
#
# =============================================================================
import re
import os
import logging
import time
import pandas as pd
import pymysql
from pandas.core.frame import DataFrame
from tornado.autoreload import start

# 调试定义logging
logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s 【 %(process)d 】 %(processName)s %(message)s"
)


def createtable(wyName):
    print('连接到mysql服务器...')
    # 打开数据库连接
    # 用户名:root, 密码:123456.,用户名和密码需要改成你自己的mysql用户名和密码，并且要先创建数据库test，并在test数据库中创建好网元gt表
    db = pymysql.connect(
        host="172.41.11.76",
        user="root",
        passwd="123456",
        port=3306,
        db="GT",
        charset='utf8',
        cursorclass=pymysql.cursors.DictCursor)
    print('连接上了!')
    # 使用cursor()方法获取操作游标 
    cursor = db.cursor()
    # 如果存在表Sutdent先删除
    cursor.execute("DROP TABLE IF EXISTS %s" % (wyName))
    sql = 'CREATE TABLE ' + wyName + ' (TT  CHAR(255),GT CHAR(255),ES CHAR(255) )'
    # print(sql)
    # 创建网元GT表
    cursor.execute(sql)
    db.close()
    print('创建数据表成功！')


def insert(db,cursor, wyName, values):
    sql = "INSERT INTO " + wyName +"(TT,GT,ES) VALUES (%s, %s,  %s)"
    try:
        print(sql, values)
        cursor.execute(sql, values)
        db.commit()
        print('插入数据成功')
    except:
        db.rollback()
        print("插入数据失败")
    return


def replaceRe(fi):
    matchPattern = re.compile(r'DETAIL|FOLLOWS|PSW|MO|TU|ALCATEL|SEQ|SWQ|SWA-SUBSEC|DGTP|GTAR/TID|--|RESULT|CM-AH-LSTP')
    listname = []
    while 1:
        line = fi.readline()
        if not line:
               # print("Read file End or Error")
            break
        if matchPattern.search(line):         # 去除关键字所在多余行
            pass
        else:
            listname.append(line)
    return listname

def getP6gt(tt1,tt2,filename):
    db = pymysql.connect(
        host="172.41.11.76",
        user="root",
        passwd="123456",
        port=3306,
        db="GT",
        charset='utf8',
        cursorclass=pymysql.cursors.DictCursor)
    cursor = db.cursor()
    fi = open(filename,encoding='gb18030', errors='ignore')
    listname=replaceRe(fi)
    E164 = []
    E214 = []
    wflag1 =False
    wflag2 =False
    for line in listname :              # 按行读入文件，此时line的type是str
        if 'SUCCESSFUL' in line:        # 重置写标记
            wflag1 =False
            wflag2 =False
        if tt1 in line:                 # 检验tt1是否到了要写入的内容
            wflag1 = True
            wflag2 = False
        if tt2 in line:                 # 检验tt2是否到了要写入的内容
            wflag1 = False
            wflag2 = True
        if 'LAST' in line:
            wflag1 = False
            wflag2 = False
        if wflag1 == True:
            K = list(line)
            if len(K)>1:                # 去除文本中的空行
                for i in K :            # 写入需要内容
                    E164.append(i)
        if wflag2 == True:
            KK = list(line)
            if len(KK)>1:               # 去除文本中的空行
                for i in KK :           # 写入需要内容
                    E214.append(i)
                #print(newline)
    E164 = str("".join(E164))         # 合并列表元素,list转化成str
    E214 = str("".join(E214))         # 合并列表元素,list转化成str
    # print(newlines)
    E164 = E164.replace(tt1,''*14).split() # 去除tt字符，净化数据,生成list
    E214 = E214.replace(tt2,''*14).split()
    E164GT = E164[::2]
    E164ES = E164[1::2]
    E214GT = E214[::2]
    E214ES = E214[1::2]
    wyName = filename.split('_')[0]
    createtable(wyName)  # 创建表
    for i in E164GT:
        gt = i
        for x in E164ES:
            es = x
        values = (tt1,gt,es)
        insert(db,cursor, wyName, values)
    for i in E214GT:
        gt = i
        for x in E214ES:
            es = x
        values = (tt2, gt, es)
        insert(db, cursor, wyName, values)
    db.close()
    logging.info(f'花费时间：{float(" % .2f" % (time.time()-start))}秒')
    # print(gt)
    # E164List = {'TT':tt1,'GT':E164GT,'ES':E164ES}
    # E214List = {'TT':tt2,'GT':E214GT,'ES':E214ES}
    # List = dict(E164List,**E214List)
    # print(list(E164List.keys()))
    # print(list(E164List.values())[1][1])


    # DataFrame(E164List).to_excel(writer, sheet_name='' + wyName + '_E164')
    # DataFrame(E214List).to_excel(writer, sheet_name='' + wyName + '_E214')
    # logging.info(f'花费时间：{float(" % .2f" % (time.time()-start))}秒')
    # fi.close()
    return

def getP12gt(tt1,tt2,filename):
    db = pymysql.connect(
        host="172.41.11.76",
        user="root",
        passwd="123456",
        port=3306,
        db="GT",
        charset='utf8',
        cursorclass=pymysql.cursors.DictCursor)
    cursor = db.cursor()
    fi = open(filename,"r")
    E164 = []
    E214 = []
    wflag1 =False
    wflag2 =False
    for line in fi :                        # 按行读入文件，此时line的type是str
        if 'CREATE-SCCP-GT' in line:        # 重置写标记
            wflag1 =False
            wflag2 =False
            if tt1 in line:                     # 检验tt1是否到了要写入的内容
                wflag1 = True
                wflag2 = False
            if tt2 in line:                     # 检验tt2是否到了要写入的内容
                wflag1 = False
                wflag2 = True
            if wflag1 == True:
                K = list(line)
                if len(K)>1:                    # 去除文本中的空行
                    for i in K :                # 写入需要内容
                        E164.append(i)
            if wflag2 == True:
                KK = list(line)
                if len(KK)>1:                    # 去除文本中的空行
                    for i in KK :               # 写入需要内容
                        E214.append(i)
    E164 = str("".join(E164))        # 合并列表元素并且list转化成str
    E214 = str("".join(E214))
    # 去除多余字符，净化数据
    E164 = E164.replace('<', '').replace('CREATE-SCCP-GT:GT=', '').replace('TT='+tt1, '').replace(',ES=', '').replace(',GROUPID=0.', '')
    E214 = E214.replace('<', '').replace('CREATE-SCCP-GT:GT=', '').replace('TT='+tt2, '').replace(',ES=', '').replace(',GROUPID=0.', '')
    # 生成list
    E164 = E164.strip().replace("\n",",").split(',')
    E214 = E214.strip().replace("\n",",").split(',')
    E164GT = E164[::2]
    E164ES = E164[1::2]
    E214GT = E214[::2]
    E214ES = E214[1::2]
    wyName = filename.split('_')[0]
    createtable(wyName)  # 创建表
    for i in E164GT:
        gt = i
        for x in E164ES:
            es = x
        values = (tt1, gt, es)
        insert(db, cursor, wyName, values)
    for i in E214GT:
        gt = i
        for x in E214ES:
            es = x
        values = (tt2, gt, es)
        insert(db, cursor, wyName, values)
    db.close()
    # # print(len(E164GT),len(E164ES))
    # # print(len(E214GT),len(E214ES))
    # E164List = {'TT':tt1,'GT':E164GT,'ES':E164ES}
    # E214List = {'TT':tt2,'GT':E214GT,'ES':E214ES}
    # # 开始写入EXCEL
    # wyName = filename.split('_')[0]
    # DataFrame(E164List).to_excel(writer, sheet_name='' + wyName + '_E164')
    # DataFrame(E214List).to_excel(writer, sheet_name='' + wyName + '_E214')
    logging.info(f'花费时间：{float(" % .2f" % (time.time()-start))}秒')
    fi.close()
    return

def parseStp():
    # global outname
    global start
    reg0 = re.compile('(.*[^\.]+).*\.txt$', re.I)
    os.chdir(path)
    for item in os.listdir(path):
        filename = item.strip()
        # print("the filename is:%s\n" % filename.split('_')[0])
        ret2 = reg0.search(filename)
        # print(ret2)
        if(ret2):
            if(filename.upper().find("P6") != -1):
                # print(filename.split('.')[0])
                print(time.ctime() + ' 正在分析' +filename.split('_')[0] + '的GT数据……')
                start = time.time()
                getP6gt('E164_INTAL_TT0','E214_INTAL_TT0',filename)
            elif(filename.upper().find("P12") != -1):
                # outname =  ret2.group(1)
                print(time.ctime() + ' 正在分析' +filename.split('_')[0] + '的GT数据……')
                start = time.time()
                getP12gt('E164_INTAL_TT0','E214_INTAL_TT0', filename)
    # writer.save()
    return

# parseStp()
if __name__ == '__main__':
    global writer
    global path
    start1 = time.time()
    path = os.path.split(os.path.realpath(__file__))[0]  # 获取脚本所在目录
    writer = pd.ExcelWriter(path + '/' + 'outname.xlsx')
    parseStp()
    writer.save()
    logging.info(f'总花费时间：{float(" % .2f" % (time.time()-start1))}秒')

# print(parseStp())
# fo = open('test.txt',"w")
# fo.write(str(parseStp()))
# fo.close()



