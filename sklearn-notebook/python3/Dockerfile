# Usage:
# docker build -t andaag/sklearn-notebook3 .
# mkdir ml
# docker run -v $(pwd)/ml:/ml -t andaag/sklearn-notebook3

FROM ubuntu:14.04
RUN sed 's:/archive\.:/no.archive.:g' /etc/apt/sources.list -i
RUN apt-get update
RUN apt-get upgrade -y

RUN mkdir /ml
RUN locale-gen en_US en_US.UTF-8
RUN apt-get -y install  libopenblas-base libopenblas-dev
RUN apt-get -y install python3-zmq python3-pandas python3-pip cython3 python3-matplotlib python3-numexpr
RUN apt-get -y install libzmq3-dev libzmq3 git-core
RUN pip3 install --upgrade ipython[all]
RUN pip3 install mechanize
RUN pip3 install bottleneck
RUN pip3 install seaborn
RUN pip3 install --upgrade git+git://github.com/scikit-learn/scikit-learn.git@0.15.X
#make sure we use the same zmq version as the system provides
RUN rm -rf /usr/local/lib/python*/dist-packages/zmq
RUN chmod 755 /ml

#Minimize image size
RUN (apt-get remove -y --purge libzmq-dev python-dev libc-dev libzmq3-dev git-core; \
     apt-get remove -y --purge gcc cpp binutils build-essential; \
     apt-get autoremove -y; \
     apt-get clean -y)

WORKDIR /ml

ADD ./ipython_notebook_config.py /root/.ipython/profile_default/ipython_notebook_config.py

EXPOSE 8888
CMD ipython notebook --no-browser --script --ip=$(hostname -i) --port 8888

