#!/bin/bash

LOG=./01_list

echo "[START] `date "+%Y-%m-%d %H:%M:%S"`"
find / -name "*.jar" > $LOG

echo ""
echo "[Exclude in the list]"
echo "> /root/* "
#echo "> link /usr/lib/avro/avro-tools.jar -> /usr/lib/avro/avro-tools-1.7.6-cdh5.16.2.jar"
#echo "> avro-tools-1.8.2-cdh6.2.0.jar"
#echo "> parquet-tools-1.9.0-cdh6.2.0.jar"

sed -i '/root/d' $LOG
#sed -i '\/usr\/lib\/avro\/avro-tools.jar/d' $LOG
#sed -i '\/usr\/lib\/avro\/avro-tools-1.7.6-cdh5.16.2.jar/d' $LOG
#sed -i '/avro-tools-1.8.2-cdh6.2.0.jar/d' $LOG
#sed -i '/parquet-tools-1.9.0-cdh6.2.0.jar/d' $LOG

echo ""
CNT1=`cat $LOG | wc -l`
echo "List Count : $CNT1"
echo "[END] `date "+%Y-%m-%d %H:%M:%S"`"
