#!/bin/bash
#
#
# find / -name "*.jar" > list
# zipgrep "JMSAppender" /HmHome/netis/web/webapps/ROOT/WEB-INF/lib/log4j-1.2.14.jar

LIST=./01_list # 01.create-list.sh 에서 생성된 .jar가 포함된 파일 목록
LOG=./02_general.log # JMS Appender 검색시 포함안되는 메세지 저장
ERRLOG=./02_filter_target.log # JMSAppender 검색시 검색되는 메세지 저장
DELLIST=./02_list_del #에러로그에서 JMSAppender.class 삭제할 jar 파일만 별도로 저장

if [ -e $LOG ]; then
	rm -rf $LOG	
fi
touch $LOG

if [ -e $ERRLOG ]; then
	rm -rf $ERRLOG
fi
touch $ERRLOG

if [ -e $DELLIST ]; then
	rm -rf $DELLIST
fi
touch $DELLIST

# init
echo "GENERAL LOG : $LOG"
echo "ERROR LOG : $ERRLOG"
echo "DEL TARGET LIST : $DELLIST"
echo ""
echo "[START] `date "+%Y-%m-%d %H:%M:%S"`"
echo "Analyzing....."

while read line; do
	if [ -e $line ]; then
		RR=`egrep 'JMSAppender' $line`
		
		if [[ "$RR" == *matches* ]]; then
			echo "[$RR]" >> $ERRLOG
			#zipgrep "JMSAppender" $line >> $ERRLOG
			echo "" >> $ERRLOG
			echo "$line" >> $DELLIST
		else
			echo "[$line] no matches"  >> $LOG
		fi
	else
		echo "[$line] file not exists." >> $LOG
		echo "" >> $LOG
	fi
done < $LIST
echo ""
CNT2=`cat $DELLIST | wc -l`
echo "List Count : $CNT2"
echo "[END] `date "+%Y-%m-%d %H:%M:%S"`"
