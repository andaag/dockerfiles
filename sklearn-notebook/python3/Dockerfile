# Usage:
# docker build -t andaag/sklearn-notebook3 .
# mkdir ml
# docker run -v $(pwd)/ml:/ml -t andaag/sklearn-notebook3

FROM ubuntu:14.04
RUN sed 's:/archive\.:/se.archive.:g' /etc/apt/sources.list -i
RUN apt-get update
RUN apt-get upgrade -y

RUN mkdir /ml
RUN locale-gen en_US en_US.UTF-8
RUN apt-get -y install  libopenblas-base libopenblas-dev liblapack-dev gfortran && apt-get clean -y
RUN apt-get -y install python3-zmq python3-pandas python3-pip cython3 python3-matplotlib && apt-get clean -y
RUN apt-get -y install libzmq3-dev libzmq3 git-core && apt-get clean -y
RUN pip3 install --upgrade ipython[all]
RUN pip3 install mechanize
RUN pip3 install numexpr
RUN pip3 install bottleneck
RUN pip3 install --upgrade numpy
RUN pip3 install --upgrade scipy
RUN pip3 install --upgrade pandas
RUN pip3 install --upgrade git+git://github.com/scikit-learn/scikit-learn.git@0.15.X
RUN pip3 install seaborn

ADD scikit.patch /tmp/scikit.patch
RUN patch -p0 < /tmp/scikit.patch

#make sure we use the same zmq version as the system provides
RUN rm -rf /usr/local/lib/python*/dist-packages/zmq
RUN chmod 755 /ml

WORKDIR /ml

EXPOSE 8888
CMD ipython notebook --no-browser --script --ip=$(hostname -i) --port 8888

