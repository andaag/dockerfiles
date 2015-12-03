# Usage:

# docker build -t andaag/large_notebook3 .

FROM andaag/sklearn_notebook3 
ENV DEBIAN_FRONTEND noninteractive
ENV LC_ALL en_US.utf-8

RUN mkdir /root/.ssh
RUN ssh-keyscan -t rsa github.com > /root/.ssh/known_hosts

COPY requirements.txt /tmp/requirements.txt
RUN for i in $(cat /tmp/requirements.txt); do pip3 install $i; done && rm /tmp/requirements.txt && rm -rf /root/.cache
RUN python3 -m nltk.downloader -q all && mv /root/nltk_data /usr/share/nltk_data

#RUN python3 -m textblob.download_corpora / python3 -m spacy.en.download

VOLUME /ml
WORKDIR /ml

EXPOSE 8888
CMD jupyter notebook --no-browser --script --ip=0.0.0.0 --port 8888

