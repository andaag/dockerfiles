#!/bin/bash

#My personal script to start my docker containers

IMAGE="large_notebook3_mkl"
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

TARGET_PORT="9999"
if echo $IMAGE | grep -q 3; then
	TARGET_PORT="8888"
fi
echo "Opening on port $TARGET_PORT"
CMD="docker run --rm=true $VOLUMES $NVIDIA_ARGS --name=ml $ENV -p 127.0.0.1:$TARGET_PORT:8888 -ti $IMAGE"

echo ""
bash -c "$CMD"


