#
#This script is used to scp files to local from sg
#
fullfilename=$3
filename=${fullfilename##*/}
#datehour=${filename:20:10}
destfile=/root/TotalBackup/$2/$filename
srcfile=alausr@$1:/var/log/report/MeasReport/$filename
if [ -d /root/TotalBackup/$2 ];then
#echo "Ŀ¼/root/TotalBackup/$2/����!"
echo $srcfile $destfile >>/tmp/getparsepcap.log
scp  $srcfile  $destfile
else
mkdir -p /root/TotalBackup/$2
#echo "Ŀ¼/root/TotalBackup/$2/�����ɹ���"
fi
echo $srcfile $destfile >>/tmp/getparsepcap.log
scp  $srcfile  $destfile
