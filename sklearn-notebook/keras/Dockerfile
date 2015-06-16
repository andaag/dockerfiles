# Usage:

# docker build -t andaag/keras-notebook3 .

FROM andaag/large_notebook3
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get -y install build-essential python3-dev libev4 libev-dev

ADD cuda-repo-ubuntu1410_7.0-28_amd64.deb /tmp/cuda.deb
RUN dpkg -i /tmp/cuda.deb
RUN apt-get update
RUN DEBIAN_FRONTEND="noninteractive" apt-get install -y cuda

ENV LD_LIBRARY_PATH $LD_LIBRARY_PATH:/usr/local/cuda/lib64
ENV PATH $PATH:/usr/local/cuda/bin

RUN pip3 install pycuda
RUN pip3 install Theano
RUN apt-get install -y libhdf5-dev
RUN pip3 install h5py
RUN pip3 install git+https://github.com/fchollet/keras

ENV THEANO_FLAGS mode=FAST_RUN,device=gpu,floatX=float32

#make sure we use the same zmq version as the system provides
RUN rm -rf /usr/local/lib/python*/dist-packages/zmq

VOLUME /ml
WORKDIR /ml

EXPOSE 8888
CMD ipython notebook --no-browser --script --ip=0.0.0.0 --port 8888
