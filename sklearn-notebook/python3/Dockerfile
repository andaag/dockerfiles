# Usage:
# docker build -t andaag/sklearn-notebook3 .
# mkdir ml
# docker run -v $(pwd)/ml:/ml -t andaag/sklearn-notebook3

FROM ubuntu:14.04
RUN apt-get update #redo2
RUN apt-get upgrade -y && apt-get clean -y

RUN mkdir /ml
RUN locale-gen en_US en_US.UTF-8

RUN apt-get -y remove libatlas3gf-base libatlas-dev
RUN apt-get -y install libopenblas-base libopenblas-dev liblapack-dev && apt-get clean -y

RUN update-alternatives  --set libblas.so.3 /usr/lib/openblas-base/libblas.so.3
RUN update-alternatives --set liblapack.so.3 /usr/lib/lapack/liblapack.so.3

RUN apt-get -y install gfortran wget libyaml-dev libfreetype6-dev libpng-dev pkg-config && apt-get clean -y
RUN apt-get -y install ttf-bitstream-vera python3-zmq python3-pip cython3 && apt-get clean -y
RUN apt-get -y install libzmq3-dev libzmq3 git-core && apt-get clean -y
RUN pip3 install --upgrade ipython[all]
RUN pip3 install --upgrade numpy
RUN pip3 install numexpr
RUN pip3 install bottleneck
RUN pip3 install --upgrade scipy
RUN pip3 install --upgrade matplotlib
RUN pip3 install --upgrade pandas
RUN pip3 install --upgrade git+git://github.com/scikit-learn/scikit-learn.git@0.15.X
RUN pip3 install seaborn
RUN pip3 install pyyaml
RUN pip3 install http://www.nltk.org/nltk3-alpha/nltk-3.0a4.tar.gz#egg=nlt
RUN python3 -m nltk.downloader all
RUN pip3 install patsy 
RUN pip3 install git+git://github.com/statsmodels/statsmodels
RUN pip3 install husl
RUN pip3 install ggplot
RUN pip3 install gensim
RUN apt-get install -y libgeos-dev && cd /usr/lib && ln -s libgeos-3.4.2.so libgeos.so && ln -s libgeos-3.4.2.so libgeos.so.1
RUN pip3 install basemap --allow-external basemap  --allow-unverified basemap
#RUN pip3 install git+git://github.com/douban/dpark@master #not python3 compatible.

#make sure we use the same zmq version as the system provides
RUN rm -rf /usr/local/lib/python*/dist-packages/zmq
RUN chmod 755 /ml

WORKDIR /ml

EXPOSE 8888
CMD ipython notebook --no-browser --script --ip=$(hostname -i) --port 8888


