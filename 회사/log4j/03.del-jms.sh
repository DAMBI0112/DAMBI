#!/bin/bash 

# delete JMSAppender statement
#
# verify
# zipgrep "JMSAppender" $line
#
# delete class
# zip -q -d $line org/apache/log4j/net/JMSAppender.class

LOG=./03_general.log # 03.del-jms.sh 실행 결과 로그
DELLIST=./02_list_del # JMSAppender.class를 삭제할 .jar 파일 목록
listCnt=`cat $DELLIST | wc -l`

echo "[START] `date "+%Y-%m-%d %H:%M:%S"`"
if [ $listCnt != 0 ]; then
	while read line; do
		RR=$(zip -q -d $line org/apache/log4j/net/JMSAppender.class)
		echo "RR => $RR"
		if [[ "$RR" == *Nothing* ]]; then
			echo "-" >/dev/null
			echo $RR >> $LOG
		fi

		if [[ "$line" == */HmHome* ]]; then
			chown netis:netis $line
		fi
	done < $DELLIST	
else
	echo "Nothing to change."
fi
echo "[END] `date "+%Y-%m-%d %H:%M:%S"`"
