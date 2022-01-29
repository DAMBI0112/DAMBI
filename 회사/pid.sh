#!/bin/bash

#source ~/.bash_profile
source $HOME/.bash_profile
PROCESS=HM_adt_chgmgrd
#pid=($(`ps -ef | grep $PROCESS | grep -v grep | awk '{print $2}'`))
pid=($(ps -ef | grep $PROCESS | grep -v HM_adt_chgmgrd.sh | grep -v HM_adt_collectord.log | grep -v grep | awk '{print $2}'))

start() {
    if [ -z $pid ]; then
        nohup $NETIS_NMS_ROOT/bin/$PROCESS 1> /dev/null 2>&1 &
        sleep 2
        pid=($(ps -ef | grep $PROCESS | grep -v HM_adt_chgmgrd.sh | grep -v grep | awk '{print $2}'))
        echo ${pid[1]}> $NETIS_NMS_ROOT/bin/pid/HM_adt_chgmgrd.pid

    else
        echo $PROCESS "is already running : " ${pid[1]}
    fi
}

stop() {
    if [ -z $pid ]; then
        echo $PROCESS "is not running "
    else
        kill -10 ${pid[1]}
        echo $PROCESS "Process is stopped"
    fi
}

status() {
    if [ -z $pid ]; then
        echo $PROCESS "is not running "
    else
        echo $PROCESS "is running : " ${pid[1]}
    fi
}

case "$1" in
    start)
        start
        ;;
    stop)
        stop
        ;;
    status)
        status
        ;;
    *)
        echo "Usage: $0 {start|stop|status}"
        exit 1
        ;;
esac
