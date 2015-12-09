# docker build -t andaag/caffe .

#Outside of image:
#sudo modprobe nvidia-uvm
#D=`grep nvidia-uvm /proc/devices | awk '{print $1}'`
#sudo mknod -m 666 /dev/nvidia-uvm c $D 0

# Startup : docker run -ti --rm=true --device /dev/nvidia-uvm:/dev/nvidia-uvm  --device /dev/nvidia0:/dev/nvidia0 --device /dev/nvidiactl:/dev/nvidiactl  -v $(pwd)/ml:/ml andaag/caffe

#can also be built on top of large/notebook3 without mkl
FROM andaag/large_notebook2_mkl 

### CUDA: 

RUN apt-get install -y wget && apt-get clean -y
ADD cuda-repo-ubuntu1504_7.5-18_amd64.deb /tmp/cuda.deb
RUN dpkg -i /tmp/cuda.deb && rm /tmp/cuda.deb
RUN apt-get update
RUN apt-get -y --force-yes install cuda

RUN apt-get -y install build-essential libev4 libev-dev
ENV LD_LIBRARY_PATH $LD_LIBRARY_PATH:/usr/local/cuda/lib64
ENV PATH $PATH:/usr/local/cuda/bin

ADD cudnn-7.0-linux-x64-v3.0-prod.tgz /tmp
RUN cp -P /tmp/cuda/lib64/* /usr/local/cuda/lib64 && cp -P /tmp/cuda/include/* /usr/local/cuda/include && rm -rf /tmp/cuda*

### CAFFE:

RUN apt-get update && apt-get install -y \
  sudo \
  git \
  bc \
  libatlas-base-dev \
  libatlas-dev \
  libboost-all-dev \
  libopencv-dev \
  libprotobuf-dev \
  libgoogle-glog-dev \
  libgflags-dev \
  protobuf-compiler \
  libhdf5-dev \
  libleveldb-dev \
  liblmdb-dev \
  libsnappy-dev

ADD Makefile.config /tmp/Makefile.config
RUN cd / && git clone https://github.com/BVLC/caffe.git && cd caffe && \
  mv /tmp/Makefile.config . && \
  make -j"$(nproc)" all

RUN for req in $(cat /caffe/python/requirements.txt); do pip install $req; done && rm -rf /root/.cache
RUN cd /caffe/ && make pycaffe
RUN /caffe/data/ilsvrc12/get_ilsvrc_aux.sh

ENV THEANO_FLAGS mode=FAST_RUN,device=gpu,floatX=float32,optimizer_including=cudnn


EXPOSE 8888
CMD chown ml:ml /ml /nltk_data && sudo -s -E -H -u ml -- env PATH="/opt/miniconda/bin:/usr/local/cuda/bin:$PATH" PYTHONPATH="/caffe/python:$PYTHONPATH" LD_LIBRARY_PATH="/usr/local/cuda/lib64:$LD_LIBRARY_PATH" bash /home/ml/start.sh