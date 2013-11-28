#!/bin/bash

APP_NAME=""
PIDFILE="$APP_NAME.pid"

case "$1" in
    start)
        echo "Starting $APP_NAME ..."
        PID=$(your_command_line > /dev/null 2>&1 & echo $!)
        if [ -z $PID ]; then
                echo "Enable to start $APP_NAME. No PID was created"
        else
                echo $PID > $PIDFILE
                echo "$APP_NAME started"
        fi
        ;;

   status)
        if [ -f $PIDFILE ]; then
                PID=$(cat $PIDFILE)
                if [ -z "$(ps aux | grep $PID | grep -v grep)" ]; then
                        echo "$APP_NAME is dead but pidfile exists"
                else
                        echo "$APP_NAME is running"
                fi
        else
                echo "$APP_NAME is not running"
        fi
        ;;

    stop)
        echo "Stopping $APP_NAME ..."
        PID=$(cat $PIDFILE)
        if [ -f $PIDFILE ]; then
                kill -9 $PID
                echo "$APP_NAME is stopping"
                rm -f $PIDFILE
        else
                echo "$PIDFILE not found"
        fi
        ;;

    restart)
        $0 stop
        $0 start
        ;;

    *)
        echo "Usage $0 {status|start|stop|restart}"
        exit 1
        ;;
esac

exit 0