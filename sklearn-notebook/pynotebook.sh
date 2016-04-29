#!/bin/bash

#My personal script to start my docker containers

if [ "$1" == "kill" ]; then
	echo "killing ml..."
	docker kill ml
	docker rm -f ml
	exit 0
fi

oom_adjust() {
	sleep 5
	PID=$(pgrep -f 'docker.*ml')
	echo 1000 > /proc/$PID/oom_score_adj
}

oom_adjust &

IMAGE="large_notebook3"
if [ ! -z "$1" ]; then
    IMAGE="$1"
fi
IMAGE="andaag/${IMAGE}"

echo "Starting $IMAGE"
NVIDIA_ARGS=""
if [[ -e /dev/nvidia-uvm && -e /dev/nvidia0 && -e /dev/nvidiactl ]]; then
	NVIDIA_ARGS="--device /dev/nvidia-uvm:/dev/nvidia-uvm  --device /dev/nvidia0:/dev/nvidia0 --device /dev/nvidiactl:/dev/nvidiactl"
	echo "Adding CUDA access to image"
else
	echo "NOT Adding CUDA access to image"
fi

VOLUMES="-v $HOME/src/ml:/ml -v $HOME/src/ml/nltk/tmp:/nltk_data"
ENV="-e JUPYTER_ARGS=\"--script\" -e AWS_ACCESS_KEY=\"$AWS_ACCESS_KEY\" -e AWS_SECRET_KEY=\"$AWS_SECRET_KEY\""



TARGET_PORT="8888"
if docker ps  | egrep -q '\->8888/'; then
	echo "Single container already running on 8888, starting this on 9999"
	TARGET_PORT="9999"
fi
CMD="docker run --rm=true $VOLUMES $NVIDIA_ARGS --name=ml $ENV -p 127.0.0.1:$TARGET_PORT:8888 -ti $IMAGE"

echo "$CMD"
bash -c "$CMD"


