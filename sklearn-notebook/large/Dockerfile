# Usage:

# docker build -t andaag/large-notebook3 .

FROM andaag/sklearn_notebook3 
ENV DEBIAN_FRONTEND noninteractive

RUN pip3 install rodeo
RUN pip3 install 

RUN mkdir /root/.ssh
RUN ssh-keyscan -t rsa github.com > /root/.ssh/known_hosts
RUN git clone https://github.com/dmlc/xgboost.git && cd xgboost && ./build.sh && cd wrapper && python3 setup.py install && cd .. && rm -rf xgboost
RUN pip3 install nltk
RUN python3 -m nltk.downloader all
RUN pip3 install objgraph
RUN pip3 install memory_profiler

#RUN pip3 install gensim

#make sure we use the same zmq version as the system provides
RUN rm -rf /usr/local/lib/python*/dist-packages/zmq

VOLUME /ml
WORKDIR /ml

EXPOSE 8888
CMD ipython notebook --no-browser --script --ip=0.0.0.0 --port 8888

