# -*- coding: utf-8 -*-

'''
Insert items into database
@author: hakuri
'''
import MySQLdb


def InsertData(TableName, dic):
   try:
    conn = MySQLdb.connect(host='172.35.114.85', user='root',
                           passwd='123456', db='test', port=3306)  # 链接数据库
    cur = conn.cursor()
    COLstr = ''  # 列的字段
    ROWstr = ''  # 行字段
    ColumnStyle = ' VARCHAR(20)'
    for key in dic.keys():
        COLstr = COLstr+' '+key+ColumnStyle+','
        ROWstr = (ROWstr+'"%s"'+',') % (dic[key])
    #判断表是否存在，存在执行try，不存在执行except新建表，再insert
    try:
      cur.execute("SELECT * FROM  %s" % (TableName))
      cur.execute("INSERT INTO %s VALUES (%s)" % (TableName, ROWstr[:-1]))
    except MySQLdb.Error as e:
      cur.execute("CREATE TABLE %s (%s)" % (TableName, COLstr[:-1]))
      cur.execute("INSERT INTO %s VALUES (%s)" % (TableName, ROWstr[:-1]))
    conn.commit()
    cur.close()
    conn.close()
   except MySQLdb.Error as e:
       print("Mysql Error %d: %s" % (e.args[0], e.args[1]))


if __name__ == '__main__':
    dic = {"TT": "a", "GT": "b", "ES": "c"}
    InsertData('GtTable', dic)
