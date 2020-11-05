# -*- coding: utf-8 -*-
# use command : reWriteFile.py oldFileName.txt newFileName.txt

import re
import os
import sys

path = os.path.split(os.path.realpath(__file__))[0]  # 获取脚本所在目录
# param = sys.argv

# if len(param) > 3:
#     sys.exit()
# print(path)
oFile = path + "\\tmp\\oldTest.txt"
nFile = open(path + "\\tmp\\newTest.txt", "w+",
             encoding='utf-8', errors='ignore')
# print(nFile)
with open(oFile, encoding='utf-8', errors='ignore') as f2:
    while True:
        line = f2.readline() # read content line by line
		
        v = re.match(r"(.*?(\'\d(\.\d)+\',))((\d+\,)+)(\".*\")", line) # use regrex to match the content needed to be changed 
        if v:
            value = v .group(4)
            temp = value.split(",")
            maxCountNu = max(temp, key = temp.count) # in my example, to caculate the max count of one element in list
            value += maxCountNu + ","
            nFile.write((v .group(1) + value + v .group(6))) # write to new file
            nFile.write("\n")
        else:
            nFile.write(line)
        if not line: break

nFile.close()

