# Usage:
# docker build -t andaag/sklearn-notebook .
# mkdir ml
# docker run -v $(pwd)/ml:/ml -t andaag/sklearn-notebook

FROM ubuntu:14.04
RUN sed 's:/archive\.:/no.archive.:g' /etc/apt/sources.list -i
RUN apt-get update
RUN apt-get upgrade -y

RUN mkdir /ml
RUN locale-gen en_US en_US.UTF-8

RUN apt-get -y remove libatlas3gf-base libatlas-dev
RUN apt-get -y install libopenblas-base libopenblas-dev liblapack-dev && apt-get clean -y

RUN update-alternatives --set libblas.so.3 /usr/lib/openblas-base/libblas.so.3
RUN update-alternatives --set liblapack.so.3 /usr/lib/lapack/liblapack.so.3

RUN apt-get -y install gfortran wget libyaml-dev libfreetype6-dev libpng-dev pkg-config && apt-get clean -y
RUN apt-get -y install ttf-bitstream-vera python-zmq python-pip cython && apt-get clean -y
RUN apt-get -y install libzmq3-dev libzmq3 git-core && apt-get clean -y
RUN pip install --upgrade ipython[all]
RUN pip install mechanize
RUN pip install --upgrade numpy
RUN pip install numexpr
RUN pip install bottleneck
RUN pip install --upgrade scipy
RUN pip install --upgrade matplotlib
RUN pip install --upgrade pandas
RUN pip install --upgrade git+git://github.com/scikit-learn/scikit-learn.git@0.15.X
RUN pip install seaborn
RUN pip install pyyaml
RUN pip install http://www.nltk.org/nltk3-alpha/nltk-3.0a4.tar.gz#egg=nlt
RUN python -m nltk.downloader all
RUN pip install patsy 
RUN pip install git+git://github.com/statsmodels/statsmodels
RUN pip install husl
RUN pip install ggplot
RUN pip install gensim
RUN apt-get install -y libgeos-dev && cd /usr/lib && ln -s libgeos-3.4.2.so libgeos.so && ln -s libgeos-3.4.2.so libgeos.so.1
RUN pip install basemap --allow-external basemap  --allow-unverified basemap
RUN pip install git+git://github.com/douban/dpark@master

RUN wget http://d3kbcqa49mib13.cloudfront.net/spark-1.1.0-bin-hadoop2.4.tgz && tar -xzf spark-1.1.0-bin-hadoop2.4.tgz -C /usr/local/ && rm spark-1.1.0-bin-hadoop2.4.tgz
RUN cd /usr/local && ln -s spark-1.1.0-bin-hadoop2.4 spark
ENV SPARK_HOME /usr/local/spark
ENV PATH $PATH:$SPARK_HOME/bin
ENV PYTHONPATH $PYTHONPATH:$SPARK_HOME/python
ENV SPARK_MASTER_IP 127.0.0.1
RUN pip install py4j

RUN apt-get install -y openjdk-7-jdk && apt-get clean -y
ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64

#make sure we use the same zmq version as the system provides
RUN rm -rf /usr/local/lib/python*/dist-packages/zmq
RUN chmod 755 /ml

WORKDIR /ml

EXPOSE 8888
CMD ipython notebook --no-browser --script --ip=$(hostname -i) --port 8888
