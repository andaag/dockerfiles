# Usage:

# docker build -t andaag/large_notebook3 .

FROM andaag/sklearn_notebook3 
ENV DEBIAN_FRONTEND noninteractive

RUN pip3 install rodeo

RUN mkdir /root/.ssh
RUN ssh-keyscan -t rsa github.com > /root/.ssh/known_hosts
RUN git clone https://github.com/dmlc/xgboost.git && cd xgboost && git checkout f6fed76e7ee22a6e1dbfe253c039ca33dabaea48 && ./build.sh && cd wrapper && python3 setup.py install && cd .. && rm -rf xgboost
RUN pip3 install nltk
RUN python3 -m nltk.downloader all && mv /root/nltk_data /usr/share/nltk_data
RUN pip3 install objgraph
RUN pip3 install memory_profiler
RUN pip3 install blaze
RUN pip3 install git+https://github.com/andaag/scikit_helpers
RUN pip3 install dask[complete]
#RUN pip3 install gensim
RUN pip3 install spacy
RUN python3 -m spacy.en.download

#make sure we use the same zmq version as the system provides
RUN rm -rf /usr/local/lib/python*/dist-packages/zmq

VOLUME /ml
WORKDIR /ml

EXPOSE 8888
CMD ipython notebook --no-browser --script --ip=0.0.0.0 --port 8888

