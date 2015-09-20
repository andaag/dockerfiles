# Usage:

# docker build -t andaag/keras-notebook3 .

FROM andaag/large_notebook3
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get -y install build-essential python3-dev libev4 libev-dev

RUN apt-get -y install software-properties-common && add-apt-repository -y ppa:graphics-drivers/ppa
RUN echo deb http://archive.ubuntu.com/ubuntu/ vivid multiverse | tee /etc/apt/sources.list.d/multiverse.list
RUN echo deb http://archive.ubuntu.com/ubuntu/ vivid-security multiverse | tee /etc/apt/sources.list.d/multiverse2.list
RUN echo deb http://no.archive.ubuntu.com/ubuntu/ vivid-updates multiverse | tee /etc/apt/sources.list.d/multiverse3.list
RUN apt-get update
RUN DEBIAN_FRONTEND="noninteractive" apt-get install -y libcuda1-355 nvidia-cuda-dev

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
