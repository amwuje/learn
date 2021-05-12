import os
import pandas as pd
from binstar_client.inspect_package import r

path = os.path.split(os.path.realpath(__file__))[0] + '/'  # 获取脚本所在目录
csvFile = path + 'Total_DRA.csv'
exlFile = path + 'test.xlsx'

# csvFile = open(path + r'/Total_DRA.csv')
# exlFile = open(path + r'/test.xlsx')
# print(csvFile)
# print(exlFile)
readcsv = pd.read_csv(csvFile)
readexl0 = pd.read_excel(exlFile, sheet_name=0)
readexl1 = pd.read_excel(exlFile, sheet_name=1)
print(readcsv.shape[0] + 1, readcsv.shape[1])       # 获取总行数与列数
print(readexl0.shape[0] + 1, readexl0.shape[1])       # 获取总行数与列数
print(readexl1.shape[0] + 1, readexl1.shape[1])
readcsv = pd.read_csv(csvFile, nrows=5)             # nrows = 5 取前5行数据
data = pd.DataFrame(readcsv)
result0 = data.loc[data['Name'] == 'HFDRA01']    # 筛选Name = HFDRA01数据
result1 = readcsv.loc[readcsv['Name'] == 'HFDRA01']
print(result1)
# print(readexl0)
# print(readexl.head())
