# -*- coding: utf-8 -*-

import pymysql

def connectdb():
    print('连接到mysql服务器...')
    db = pymysql.connect(
        host="172.35.114.85",
        user="root",
        passwd="123456",
        port=3306,
        db="TESTDB",
        charset='utf8',
        cursorclass=pymysql.cursors.DictCursor)
    print('连接数据库成功!')
    # cursor = db.cursor()
    # sql = 'CREATE TABLE IF NOT EXISTS listed_company3 (serial_number INT NOT NULL,stock_code INT ,stock_abbre VARCHAR(20) ,company_name VARCHAR(20) ,province VARCHAR(20) ,city VARCHAR(20) ,main_bussiness_income VARCHAR(20) ,net_profit VARCHAR(20) ,employees INT ,listing_date DATETIME(0) ,zhaogushu VARCHAR(20) ,financial_report VARCHAR(20) , industry_classification VARCHAR(20) ,industry_type VARCHAR(100) ,main_business VARCHAR(200) ,PRIMARY KEY (serial_number))'
    # cursor.execute(sql)
    # db.close()
    return db


def createtable(db):
    # 使用cursor()方法获取操作游标 
    cursor = db.cursor()
    # 如果存在表Sutdent先删除
    cursor.execute("DROP TABLE IF EXISTS Student")
    sql = 'CREATE TABLE Student (ID CHAR(10) NOT NULL,Name CHAR(8),Grade INT )'
    # 创建Sutdent表
    cursor.execute(sql)
    print('创建数据表成功！')


def main():
    db = connectdb()     # 连接数据库
    createtable(db)      # 创建数据表
    db.commit()
    db.close()

if __name__ == '__main__':
    main()
