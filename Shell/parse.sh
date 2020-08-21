#
#This script is used to get the remote csv file list firstly, then call getparsepcap.sh to download these csv files and analyze them
#

wy_ip=$1
wy_name=$2
data_home=/var/log/report/MeasReport
ssh alausr@$wy_ip find $data_home -type f -name '\*0000.csv'   -mtime -1 > /tmp/curDataFileList
for  i  in  `cat /tmp/curDataFileList`
do
#echo $i
{ /root/getparsepcap.sh ${wy_ip}  ${wy_name} ${i}& }
sleep 1
done
