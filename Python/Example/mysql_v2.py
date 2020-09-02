# -*- coding: utf-8 -*-

import pymysql


def connectdb():
    # 指定数据库地址、用户、密码、端口，使用connect()方法声明一个Mysql连接对象db
    db = pymysql.connect(host='172.41.11.76', user='root',
                    password='123456', port=3306)
    # 调用cursor()方法获得M  ysql的操作游标，利用游标来执行SQL语句。
    cursor = db.cursor()
    return db, cursor


def showVer(cursor):
    # 直接用execute()方法执行，第一句用于获得Mysql版本，然后调用fetchone()方法获得第一条数据。
    cursor.execute('SELECT VERSION()')
    data = cursor.fetchone()
    print('Database version:', data)
    return


def createData(cursor):
    # 删除名称为spiders的数据库
    cursor.execute('drop database spiders')
    print('删除数据库成功！')
    # 创建名称为spiders的数据库
    cursor.execute("CREATE DATABASE spiders DEFAULT CHARACTER SET utf8")
    print('创建数据库成功！')
    # 引用数据库spiders
    cursor.execute('use spiders')
    return


def createTable(cursor):
    # 创建一个名为students的数据表
    sql = 'CREATE TABLE IF NOT EXISTS students (id VARCHAR(255) NOT NULL, name VARCHAR(255) NOT NULL, age INT NOT NULL, PRIMARY KEY (id))'
    cursor.execute(sql)
    print('创建表成功！')
    return


def insertValues(db,cursor):
    # 插入数据
    # 定义数据
    id = '20120001'
    user = 'Bob'
    age = 20

    sql = 'INSERT INTO students(id, name, age) values(%s, %s, %s)'
    try:
        cursor.execute(sql, (id, user, age))
        db.commit()
        print('添加数据成功！')
    except:
        db.rollback()


def insertDic(db, cursor):
    # 插入数据（字典）
    # 构造字典
    data = {
        'id': '20120001',
        'name': 'Bob',
        'age': 20
    }
    table = 'students'
    #keys的结果是 id,name,age
    keys = ', '.join(data.keys())
    #values的结果是 %s, %s, %s
    values = ', '.join(['%s'] * len(data))
    #使用format()方法将表名、字段名和占位符构造出来。
    #最终的SQL语句就被动态构造成 INSERT INTO students (id,name,age) VALUES (%s, %s, %s)
    sql = 'INSERT INTO {table}({keys}) VALUES ({values})'.format(table=table, keys=keys, values=values)
    # print(sql)
    try:
        if cursor.execute(sql, tuple(data.values())):
            print('Successful')
            db.commit()
    except:
        print('Failed')
        db.rollback()


def updateValue(db, cursor):
    # 更新数据
    data = {
        'id': '20120001',
        'name': 'Bob',
        'age': 20
    }
    table = 'students'
    keys = ', '.join(data.keys())
    values = ', '.join(['%s'] * len(data))

    sql = 'UPDATE students SET age = %s WHERE name = %s'
    try:
        # cursor.execute(sql, (25, 'Bob'))
        db.commit()
        print('数据更新成功！')
    except:
        db.rollback()


# 更新数据（去重）
def updateValues(db, cursor):
    data = {
        'id': '20120001',
        'name': 'Bob',
        'age': 21
    }
    table = 'students'
    keys = ', '.join(data.keys())
    values = ', '.join(['%s'] * len(data))
    #SQL语句 ON DUPLICATE KEY UPDATE表示如果主键已经存在就执行更新操作i
    #sql的值为 INSERT INTO students(id, name, age) VALUES (%s, %s, %s) ON DUPLICATE KEY UPDATE
    sql = 'INSERT INTO {table}({keys}) VALUES ({values}) ON DUPLICATE KEY UPDATE'.format(table=table, keys=keys,
                                                                                        values=values)
    update = ','.join([" {key} = %s".format(key=key) for key in data])
    #sql的值更新为INSERT INTO students(id, name, age) VALUES (%s, %s, %s) ON DUPLICATE KEY UPDATE id = %s, name = %s, age = %s
    sql += update
    try:
        if cursor.execute(sql, tuple(data.values()) * 2):
            print('Successful')
            db.commit()
    except:
        print('Failed')
        db.rollback()


def selectValues(db, cursor):
    # 查询数据
    sql = 'SELECT * FROM students WHERE age >= 20'
    try:
        cursor.execute(sql)
        #输出长度
        print('Count:', cursor.rowcount)
        #获取结果的第一条数据
        row = cursor.fetchone()
        while row:
            print('Row:', row)
            row = cursor.fetchone()
    except:
        print('Error')


def deleteValues(db, cursor):
    # 删除数据
    table = 'students'
    condition = 'age > 20'

    sql = 'DELETE FROM  {table} WHERE {condition}'.format(
        table=table, condition=condition)
    try:
        cursor.execute(sql)
        db.commit()
        print('数据删除成功！')
    except:
        db.rollback()


def closedb(db):
    db.close()


def main():
    db, cursor = connectdb()    # 连接MySQL数据库
    showVer(cursor)             # 显示数据库版本
    createData(cursor)          # 删除创建数据库
    createTable(cursor)         # 创建表
    insertValues(db, cursor)    # 插入数据
    updateValue(db, cursor)     # 更新数据
    updateValues(db, cursor)    # 更新去重数据
    selectValues(db, cursor)    # 显示数据
    deleteValues(db, cursor)    # 删除数据
    closedb(db)                 # 关闭数据库


if __name__ == '__main__':
    main()
