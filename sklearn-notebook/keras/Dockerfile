# Usage:

# docker build -t andaag/keras-notebook3 .


#Outside of image:
# sudo modprobe nvidia-uvm
# D=`grep nvidia-uvm /proc/devices | awk '{print $1}'`
# sudo mknod -m 666 /dev/nvidia-uvm c $D 0

# You will also need the same cuda version. Meaning cuda -i cuda-repo-ubuntu1504_7.5-18_amd64.deb && apt-get update && apt-get install cuda on ubuntu 15.04.

#I run the image with : docker run --privileged --rm=true --device /dev/nvidia-uvm:/dev/nvidia-uvm  --device /dev/nvidia0:/dev/nvidia0 --device /dev/nvidiactl:/dev/nvidiactl  -v /home/neuron/src/ml:/ml  -v /home/neuron/tmp/ml:/mnt --name="keras" -p 9999:9999 -t -i $IMAGE bash -c "umount /dev/shm ; mount -t tmpfs tmpfs -o rw,nosuid,nodev /dev/shm ; echo Listening on ; hostname -i ; groupadd ml && useradd ml -m -g ml -u 1000 && chown ml:ml /ml && sudo THEANO_FLAGS=mode=FAST_RUN,device=gpu,floatX=float32 LD_LIBRARY_PATH=/usr/local/cuda/lib64 PATH="$PATH:/usr/local/cuda/bin" PYTHONUNBUFFERED=1 -sHu ml ipython notebook --no-browser --script --ip=0.0.0.0 --port 9999" -p 127.0.0.1:9999:9999

#The important path is  the device files

FROM andaag/large_notebook3
ENV DEBIAN_FRONTEND noninteractive
ADD cuda-repo-ubuntu1504_7.5-18_amd64.deb /tmp/cuda.deb
RUN dpkg -i /tmp/cuda.deb
RUN apt-get update
RUN apt-get -y install cuda

RUN apt-get -y install build-essential python3-dev libev4 libev-dev
ENV LD_LIBRARY_PATH $LD_LIBRARY_PATH:/usr/local/cuda/lib64
ENV PATH $PATH:/usr/local/cuda/bin


RUN pip3 install pycuda
RUN pip3 install Theano
RUN apt-get install -y libhdf5-dev
RUN pip3 install h5py
RUN pip3 install git+https://github.com/fchollet/keras

ENV THEANO_FLAGS mode=FAST_RUN,device=gpu,floatX=float32

VOLUME /ml
WORKDIR /ml

EXPOSE 8888
CMD ipython notebook --no-browser --script --ip=0.0.0.0 --port 8888
