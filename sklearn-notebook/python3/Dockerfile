# Usage:
# docker build -t andaag/sklearn-notebook3 .
# mkdir ml
# docker run -v $(pwd)/ml:/ml -t andaag/sklearn-notebook3

FROM ubuntu:14.04
RUN apt-get update
RUN apt-get upgrade -y && apt-get clean -y

RUN mkdir /ml && chmod 755 /ml
RUN locale-gen en_US en_US.UTF-8

RUN apt-get -y remove libatlas3gf-base libatlas-dev
RUN apt-get -y install libopenblas-base libopenblas-dev liblapack-dev && apt-get clean -y

RUN update-alternatives  --set libblas.so.3 /usr/lib/openblas-base/libblas.so.3
RUN update-alternatives --set liblapack.so.3 /usr/lib/lapack/liblapack.so.3

RUN apt-get -y install build-essential gfortran wget libyaml-dev libfreetype6-dev libpng-dev pkg-config && apt-get clean -y
RUN apt-get -y install ttf-bitstream-vera python3-zmq cython3 && apt-get clean -y
RUN apt-get -y install libzmq3-dev libzmq3 git-core && apt-get clean -y
RUN wget https://bootstrap.pypa.io/get-pip.py && python3 get-pip.py
RUN pip3 install --upgrade ipython[all]
RUN pip3 install --upgrade numpy
RUN pip3 install numexpr #performance
RUN pip3 install bottleneck #performance
RUN pip3 install --upgrade scipy
RUN pip3 install --upgrade matplotlib
RUN pip3 install --upgrade pandas
RUN pip3 install objgraph
RUN pip3 install memory_profiler
RUN pip3 install nltk
RUN python3 -m nltk.downloader all
RUN pip3 install git+git://github.com/statsmodels/statsmodels
RUN pip3 install seaborn
RUN pip3 install --upgrade git+git://github.com/scikit-learn/scikit-learn.git@0.16.X
#RUN pip3 install gensim

#make sure we use the same zmq version as the system provides
RUN rm -rf /usr/local/lib/python*/dist-packages/zmq

VOLUME /ml
WORKDIR /ml

EXPOSE 8888
ENV PYTHONUNBUFFERED=1
CMD ipython notebook --no-browser --script --ip=0.0.0.0 --port 8888