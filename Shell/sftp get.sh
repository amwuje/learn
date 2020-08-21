#!/bin/bash
#SFTP配置信息
#IP
IP=10.225.191.245
#端口
PORT=22
#用户名
USER=alausr
#密码
PASSWORD=Chji826@1
#待接收下载文件根目录
CLIENTDIR=/root/TotalBackup
#服务器待下载目录
SEVERDIR=/var/measfile/Recently/
#待下载文件名
FILE=6-N7SCCP_20190929.211500.csv 

lftp -u ${USER},${PASSWORD} sftp://${IP}:${PORT} <<EOF
cd ${SEVERDIR}/
lcd ${CLIENTDIR}
get ${FILE}
by
EOF
