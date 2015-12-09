#!/bin/bash

oom_adjust() {
    sleep 5
    PID=$(pgrep -f 'jupyter')
    echo 1000 > /proc/$PID/oom_score_adj
}
oom_adjust &

echo "Starting jupyter with arguments from JUPYTER_ARGS, final command:" 
echo "nice jupyter $JUPYTER_ARGS notebook"

nice jupyter notebook $JUPYTER_ARGS /ml