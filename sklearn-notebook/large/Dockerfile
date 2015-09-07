# Usage:

# docker build -t andaag/large_notebook3 .

FROM andaag/sklearn_notebook3 
ENV DEBIAN_FRONTEND noninteractive

RUN mkdir /root/.ssh
RUN ssh-keyscan -t rsa github.com > /root/.ssh/known_hosts

RUN git clone https://github.com/dmlc/xgboost.git && cd xgboost && git checkout f6fed76e7ee22a6e1dbfe253c039ca33dabaea48 && ./build.sh && cd wrapper && python3 setup.py install && cd .. && rm -rf xgboost
RUN pip3 install nltk && rm -rf /root/.cache
RUN python3 -m nltk.downloader all && mv /root/nltk_data /usr/share/nltk_data
RUN pip3 install objgraph && rm -rf /root/.cache
RUN pip3 install memory_profiler && rm -rf /root/.cache
RUN pip3 install blaze && rm -rf /root/.cache
RUN pip3 install git+https://github.com/andaag/scikit_helpers && rm -rf /root/.cache 
RUN pip3 install dask[complete] && rm -rf /root/.cache
# python 2.x only .. RUN pip3 install graphlab-create

#RUN pip3 install gensim && rm -rf /root/.cache

#RUN pip3 install spacy && rm -rf /root/.cache
#RUN python3 -m spacy.en.download

RUN pip3 install pyyaml && git clone --depth=1 https://github.com/ipython-contrib/IPython-notebook-extensions.git && \
	cd IPython-notebook-extensions && ipython3 setup.py install && rm -rf /root/IPython-notebook-extensions


VOLUME /ml
WORKDIR /ml

EXPOSE 8888
CMD ipython notebook --no-browser --script --ip=0.0.0.0 --port 8888

