#!/bin/bash
#SFTP������Ϣ
#IP
IP=10.225.191.245
#�˿�
PORT=22
#�û���
USER=alausr
#����
PASSWORD=Chji826@1
#�����������ļ���Ŀ¼
CLIENTDIR=/root/TotalBackup
#������������Ŀ¼
SEVERDIR=/var/measfile/Recently/
#�������ļ���
FILE=6-N7SCCP_20190929.211500.csv 

lftp -u ${USER},${PASSWORD} sftp://${IP}:${PORT} <<EOF
cd ${SEVERDIR}/
lcd ${CLIENTDIR}
get ${FILE}
by
EOF
