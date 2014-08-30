# Usage:
# docker build -t andaag/sklearn-notebook3 .
# mkdir ml
# docker run -v $(pwd)/ml:/ml -t andaag/sklearn-notebook3

FROM ubuntu:14.04
RUN apt-get update
RUN apt-get upgrade -y

RUN mkdir /ml
RUN locale-gen en_US en_US.UTF-8
RUN apt-get -y install  libopenblas-base libopenblas-dev liblapack-dev gfortran wget libyaml-dev && apt-get clean -y
RUN apt-get -y install ttf-bitstream-vera python3-zmq python3-pandas python3-pip cython3 python3-matplotlib && apt-get clean -y
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
RUN pip3 install pyyaml
RUN pip3 install http://www.nltk.org/nltk3-alpha/nltk-3.0a4.tar.gz#egg=nlt
RUN python3 -m nltk.downloader all

#make sure we use the same zmq version as the system provides
RUN rm -rf /usr/local/lib/python*/dist-packages/zmq
RUN chmod 755 /ml

WORKDIR /ml

EXPOSE 8888
CMD ipython notebook --no-browser --script --ip=$(hostname -i) --port 8888

